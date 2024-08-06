trigger repAccountUpdate on Account (after update) {

    List<Account> acc = [SELECT Account.Name FROM Account WHERE Type = 'Prospect' ];

    System.enqueuejob(new UpdateAccountTrigger(acc));

}