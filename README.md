CoreKitty :cat: :cat2:
========= 

"Cat"egory for Core Data

### Why ?
Writing Core Data fetch boilerplate is tedious. A single category for the most
common fetch and aggregate functions keeps things simple and lightweight. No
subclassing NSManagedObject or extra framework required.

### Features (planned V1)

- recordCount
- find all fieldname equal to value (NSString, int, Bool, Date)
- count all fieldname equal to value (NSString, int, Bool, Date)
- All operations parameterizable per NSManagedContext which makes integration with NSOperationQueue or background thread possible.
- Aggregate functions min, max, avg of given field

Upon inclusion, CoreKitty figures out the cooresponding CoreData entity
class and becomes schema aware. Autoconfiguration and schema awareness makes
CoreKitty powerful, convenient and resilient to mistyped field names.

### Installation
- Add NSManagedObject+CoreKitty category to your project. 
- #import on any NSManagedObject subclass
- Enjoy!

### Howto Contribute
CoreKitty is in active development and pull requests are gladly accepted for V1
features, as well as any other convenient methods not listed. When submitting
and pull request, please also include a corresponding Kiwi test.
