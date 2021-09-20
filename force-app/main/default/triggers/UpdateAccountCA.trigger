trigger UpdateAccountCA on Order (before update) {

    AccountUtility.updateAccountTurnover(Trigger.New);
    
}