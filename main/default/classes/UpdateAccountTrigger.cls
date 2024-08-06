public class UpdateAccountTrigger implements Queueable

{

    List <Account> AccountsToUpdate= new List<Account>();

    public UpdateAccountTrigger (List<Account> TriggeredAccList )

    {

        AccountsToUpdate = TriggeredAccList ;

    }

    public void execute(QueueableContext context)

    {

        for(Account acc: AccountsToUpdate)

        {

            if (acc.Type == 'Prospect')

            {

                acc.Type ='Other';

            }

        }

        update AccountsToUpdate;

    }

}