trigger NewAccountTrigger on Account (before insert) {
    System.debug('A new Account has been created!');
}