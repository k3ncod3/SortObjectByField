@isTest
private class SortObjectByFieldTest {
    
    @isTest
    static void testSortByField() {
        // Create some test accounts
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name='Acme'));
        accounts.add(new Account(Name='Beta'));
        accounts.add(new Account(Name='Gamma'));
        insert accounts;
        
        // Create some test contacts with different account assignments
        List<Contact> contacts = new List<Contact>();
        contacts.add(new Contact(FirstName='Alice', LastName='Anderson', Email='alice@example.com', AccountId=accounts[0].Id));
        contacts.add(new Contact(FirstName='Bob', LastName='Brown', Email='bob@example.com', AccountId=accounts[1].Id));
        contacts.add(new Contact(FirstName='Charlie', LastName='Chaplin', Email='charlie@example.com', AccountId=accounts[2].Id));
        contacts.add(new Contact(FirstName='Diana', LastName='Doe', Email='diana@example.com', AccountId=accounts[0].Id));
        contacts.add(new Contact(FirstName='Eve', LastName='Evans', Email='eve@example.com', AccountId=accounts[1].Id));
        insert contacts;
        
        // Test sorting contacts by last name ascending
        List<Contact> sortedContacts = (List<Contact>)SortObjectByField.sortByField('Contact', 'LastName', true, contacts);
        System.assertEquals(5, sortedContacts.size());
        System.assertEquals('Anderson', sortedContacts[0].LastName);
        System.assertEquals('Brown', sortedContacts[1].LastName);
        System.assertEquals('Chaplin', sortedContacts[2].LastName);
        System.assertEquals('Doe', sortedContacts[3].LastName);
        System.assertEquals('Evans', sortedContacts[4].LastName);
        
        // Test sorting contacts by first name descending
        sortedContacts = (List<Contact>)SortObjectByField.sortByField('Contact', 'FirstName', false, contacts);
        System.assertEquals(5, sortedContacts.size());
        System.assertEquals('Eve', sortedContacts[0].FirstName);
        System.assertEquals('Diana', sortedContacts[1].FirstName);
        System.assertEquals('Charlie', sortedContacts[2].FirstName);
        System.assertEquals('Bob', sortedContacts[3].FirstName);
        System.assertEquals('Alice', sortedContacts[4].FirstName);
    }
    
}
