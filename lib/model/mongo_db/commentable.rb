module Model::MongoDb::Commentable
  def comments
    mongo_db_document = MongoDbDocument.where(
      mongo_db_object_id: self.id.to_s, klass_name: self.class.name
    ).first
    
    if mongo_db_document
      Comment.where(commentable_type: 'MongoDbDocument', commentable_id: mongo_db_document.id)
    else
      []
    end
  end
end