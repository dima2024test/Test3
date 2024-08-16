trigger TestUpdatedTrigger on Case (before insert, before update) {
    // Get the current user's profile name
    String currentUserProfileName = [SELECT Id, Profile.Name 
                                    FROM User 
                                    WHERE Id = :UserInfo.getUserId()].Profile.Name;
    
    // Define the mapping of profiles to case owners
    Map<String, String> profileToCaseOwnerMap = new Map<String, String> {
        'System Administrator' => '005aj000006555555'// Replace with actual User ID
        
        
    };
    
    // Iterate through the new or updated Case records
    for (Case c : Trigger.new) {
        // Check if the case owner needs to be updated
        if (c.OwnerId == null || c.OwnerId != profileToCaseOwnerMap.get(currentUserProfileName)) {
            c.OwnerId = profileToCaseOwnerMap.get(currentUserProfileName);
        }
    }
}