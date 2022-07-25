//
//  MusicFileDB.swift
//  MusicAlbum
//
//  Created by Sameer on 7/22/22.
//

import UIKit
import RealmSwift


class GenresDB: Object {


    @objc dynamic var url = ""
    @objc dynamic var genreId = ""
    @objc dynamic var name = ""


    public static func addGenresObj(model: GenresModel) -> GenresDB {
        
        let obj = GenresDB()
        
        obj.genreId = model.genreId ?? ""
        obj.name = model.name ?? ""
        obj.url = model.url ?? ""
        
        return obj
    }
}


class FeedDB: Object {


    @objc dynamic var title = ""
    @objc dynamic var id = ""
    @objc dynamic var copyright = ""
    @objc dynamic var country = ""
    @objc dynamic var icon = ""
    @objc dynamic var updated = ""
  
    override class func primaryKey() -> String {
        return "id"
    }
    
    public static func addFeedObj(model: FeedModel) -> FeedDB {

        let obj = FeedDB()


        obj.title = model.title ?? ""
        obj.id = model.id ?? ""
        obj.copyright = model.copyright ?? ""
        obj.country = model.country ?? ""
        obj.icon = model.icon ?? ""
        obj.updated = model.updated ?? ""
        return obj
      }
}




class MusicFileDB: Object {


    @objc dynamic var artistName = ""
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var releaseDate = ""
    @objc dynamic var kind = ""
    @objc dynamic var artistId = ""
    @objc dynamic var artistUrl = ""
    @objc dynamic var artworkUrl100 = ""
    @objc dynamic var url = ""
    @objc dynamic var contentAdvisoryRating = ""

    
    var arrGenres = List<GenresDB>()

    override class func primaryKey() -> String {
        return "id"
    }
    
    public static func addMusicObj(model: MusicModel) -> MusicFileDB {

        let obj = MusicFileDB()


        obj.artistName = model.artistName ?? ""
        obj.id = model.id ?? ""
        obj.name = model.name ?? ""
        obj.artworkUrl100 = model.artworkUrl100 ?? ""
        obj.releaseDate = model.releaseDate ?? ""
        obj.url = model.url ?? ""

        if let arrGenres = model.genres {
            for genresObj in arrGenres {
                let objGenresDB = GenresDB()
                objGenresDB.genreId = genresObj.genreId ?? ""
                objGenresDB.name = genresObj.name ?? ""
                objGenresDB.url = genresObj.url ?? ""
                obj.arrGenres.append(objGenresDB)
            }
        }

        return obj
      }
}

class DBManager {

    private var database:Realm
    static let   sharedInstance = DBManager()

    private init() {
        let config = Realm.Configuration(
          // Set the new schema version. This must be greater than the previously used
          // version (if you've never set a schema version before, the version is 0).
          schemaVersion: 2,

          // Set the block which will be called automatically when opening a Realm with
          // a schema version lower than the one set above
          migrationBlock: { migration, oldSchemaVersion in
            // We haven’t migrated anything yet, so oldSchemaVersion == 0
            if (oldSchemaVersion < 2) {
              // Nothing to do!
              // Realm will automatically detect new properties and removed properties
              // And will update the schema on disk automatically
            }
          })

        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config

        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration

        database = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

    func writeTransaction(completion:@escaping() -> ()){
       try! database.write({
            completion()
        })
    }

    
    func objectMusicDBExist(id: String) -> Bool {
        return database.object(ofType: MusicFileDB.self, forPrimaryKey: id) != nil
    }
    
    func objectFeedDBExist(id: String) -> Bool {
        return database.object(ofType: FeedDB.self, forPrimaryKey: id) != nil
    }
    
    
    /**
     Save object to realm database
     */
    func saveObject(obj: Object) {
        
        try! self.database.write({
            self.database.add(obj)
        })
    }

    /**
     Returs an array as [Object]
     */
    func getObjects(type: Object.Type) -> [Object] {
        
        
        var objects = [Object]()
        for result in self.database.objects(type) {
            objects.append(result)
        }
        return objects
        
    }
    
//    /**
//     Delete local database
//     */
//    func deleteDatabase() {
//        try! self.database.write({
//            self.database.deleteAll()
//        })
//    }
//
//
//    /*
//     * Updates objects
//     */
//
//    func saveAndUpdateObject(obj: Object, completion : @escaping() -> ()) {
//            try! self.database.write({
//                self.database.add(obj, update: .all)
//                completion()
//            })
//
//    }
//
//
//
//    func getObject(for query: String, type: Object.Type) -> Object? {
//       let objs =  database.objects(type).filter(query)
//       return objs.first
//    }
//
//    func getObjects(for query: String, type: Object.Type) -> [Object]? {
//        let objs =  database.objects(type).filter(query)
//        var objects = [Object]()
//        for result in objs {
//            objects.append(result)
//        }
//        return objects
//    }
//
//    func deleteObject(obj: Object, completion : @escaping() -> ()){
//        try! database.write({
//            database.delete(obj)
//            completion()
//         })
//
//
//    }
//
//    func deleteObjects(objs: [Object], completion : @escaping() -> ()){
//        try! database.write({
//            database.delete(objs)
//            completion()
//        })
//    }

}
