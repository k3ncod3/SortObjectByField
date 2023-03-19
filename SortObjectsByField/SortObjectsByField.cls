public class SortObjectByField {
    
    public static List<sObject> sortByField(String objectType, String fieldName, Boolean ascending, List<sObject> records) {
        // Build SOQL query dynamically
        String query = 'SELECT ';
        for (Schema.SObjectField field : Schema.getGlobalDescribe().get(objectType).getDescribe().fields.getMap().values()) {
            query += field.getDescribe().getName() + ', ';
        }
        query = query.substring(0, query.length() - 2) + ' FROM ' + objectType;
        if (records != null && !records.isEmpty()) {
            Set<Id> ids = new Set<Id>();
            for (sObject record : records) {
                ids.add(record.Id);
            }
            query += ' WHERE Id IN :ids';
        }
        query += ' ORDER BY ' + fieldName + (ascending ? ' ASC' : ' DESC');
        System.debug('Query: ' + query);
        
        // Execute query and return sorted records
        List<sObject> sortedRecords = Database.query(query);
        System.debug('Number of records returned: ' + sortedRecords.size());
        return sortedRecords;
    }
    
}