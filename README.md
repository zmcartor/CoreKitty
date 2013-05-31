CoreKitty :cat: :cat2:
========= 

"Cat"egory for Core Data 'findBy' accessors

### Why ?
Writing Core Data lookup boilerplate is a bummer. The *findBy<fieldname>* methods from other dynamic languages make data lookup easy. A single category provides simple but powerful enhancements which make finding and sorting enities less of an NSHassle.

Also Metaprogramming in ObjC is fun! :frog:

### Installation
- Add the NSManagedObject+CoreKitty category to your project. 
- #import on any NSManagedObject subclass
- Because of the nature of ARC, selectors you'd like to use need to be declared in either the .h or a private class extension.
 It is *not* necessary to declare a findBy selector for every single field in the model.

Example:
```objc
// MyModel.h
+ (NSArray *)findByFirstName:(NSString *);
+ (NSArray *)findBySomeFieldName:(NSString *);
```
That's it! Now running :

```objc
NSArray *results = [MyModel findByName:@"Homer"];
```

Will fetch all people models where name = Homer, autometa-magically!

### Errata and todos
Has not yet been profiled. Use at your own risk in mission critical apps.

#### Coming Features 

Additional 'find' selectors
- findByField1AndField2AndField3 .. etc in a vArgs type list.
- findNot (inverse of findBy)
- support Core Data relational fields



