trigger TestDeleteTrigger on Contact (after insert, after update) {
    // Create a set to store the unique contact IDs
    Set<Id> contactIds = new Set<Id>();
    
    // Iterate through the new or updated Contact records
    for (Contact c : Trigger.new) {
        // Check if the contact's "Preferred Contact Method" field is set to "Email"
        if (c.Name == 'Email') {
            // Add the contact ID to the set
            contactIds.add(c.Id);
        }
    }
    
    // Create a new task for each contact with "Email" as the preferred contact method
    if (!contactIds.isEmpty()) {
        List<Task> tasks = new List<Task>();
        for (Contact c : [SELECT Id, Name FROM Contact WHERE Id IN :contactIds]) {
            Task t = new Task();
            t.WhoId = c.Id;
            t.Subject = 'Follow up with ' + c.Name;
            t.Status = 'Open';
            t.Priority = 'Medium';
            tasks.add(t);
        }
        insert tasks;
    }
}