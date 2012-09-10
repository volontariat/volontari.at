class CreateSchema < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
      t.string :slug
      t.string :rpx_identifier
      t.string :password
      t.text :text
      t.text :serialized_private_key
      
      # profile 
      t.string :language
      t.string :first_name
      t.string :last_name
      t.string :salutation
      t.string :marital_status
      t.string :family_status
      t.date :date_of_birth
      t.string :place_of_birth
      t.string :citizenship
      
      # devise authentication data
      
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Token authenticatable
      t.string :authentication_token

      t.string :password_salt # Encryptable
     
      t.string :state
      t.timestamps
    end
    
    add_index :users, :slug, unique: true
    add_index :users, :name,                 unique: true
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    
    create_table :roles do |t|
      t.string :name
      t.string :state
      t.timestamps
    end
    
    create_table :users_roles do |t|
      t.integer :role_id
      t.integer :user_id
      t.string :state
      t.timestamps
    end
    
    add_index :users_roles, [:user_id, :role_id], unique: true
    
    create_table :projects do |t|
      t.integer :user_id
      t.string :name
      t.string :slug
      t.text :text
      t.string :url
      t.string :state
      t.timestamps
    end
    
    add_index :projects, :slug, unique: true
    add_index :projects, :user_id
    
    create_table :vacancies do |t|
      t.string :type # job, location, money
      t.integer :project_id
      t.integer :offeror_id
      t.integer :author_id
      t.integer :user_id
      t.integer :project_user_id
      t.string :name
      t.string :slug
      t.text :text
      t.integer :limit, default: 1
      t.string :state
      t.timestamps
    end
    
    add_index :vacancies, :slug, unique: true
    add_index :vacancies, [:project_id, :name], unique: true
    add_index :vacancies, :project_id
    add_index :vacancies, :offeror_id
    add_index :vacancies, :user_id
    add_index :vacancies, :project_user_id
    
    create_table :candidatures do |t|
      t.integer :vacancy_id
      t.integer :offeror_id
      t.integer :user_id
      t.string :name
      t.string :slug
      t.text :text
      t.string :state
      t.timestamps
    end
    
    add_index :candidatures, :slug, unique: true
    add_index :candidatures, [:vacancy_id, :name], unique: true
    add_index :candidatures, :vacancy_id
    add_index :candidatures, :user_id
    
    # project stellen ausschreibung
    # bewerbung (project, project stelle)
    
    create_table :projects_users do |t|
      t.integer :project_id
      t.integer :vacancy_id
      t.integer :role_id
      t.integer :user_id
      t.string :state
      t.timestamps
    end
    
    add_index :projects_users, [:project_id, :user_id, :vacancy_id], unique: true
    add_index :projects_users, :project_id
    add_index :projects_users, :vacancy_id
    add_index :projects_users, :role_id
    add_index :projects_users, :user_id
    
    create_table :areas do |t|
      t.string :ancestry
      t.integer :ancestry_depth, default: 0
      t.integer :position
      t.string :name
      t.string :slug
      t.integer :users_count, default: 0
      t.timestamps
    end
    
    add_index :areas, :slug, unique: true
    add_index :areas, :ancestry
    add_index :areas, :name, unique: true
    
    create_table :areas_users do |t|
      t.integer :area_id
      t.integer :user_id
      t.timestamps
    end
    
    add_index :areas_users, [:area_id, :user_id], unique: true
    add_index :areas_users, :area_id
    add_index :areas_users, :user_id
    
    create_table :areas_projects do |t|
      t.integer :area_id
      t.integer :project_id
      t.timestamps
    end
    
    add_index :areas_projects, [:area_id, :project_id], unique: true
    add_index :areas_projects, :area_id
    add_index :areas_projects, :project_id
    
    create_table :comments do |t|
      t.string :commentable_type
      t.integer :commentable_id
      t.integer :user_id
      t.string :ancestry
      t.integer :ancestry_depth, default: 0
      t.integer :position
      t.string :name
      t.text :text
      t.string :state
      t.timestamps
    end
    
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :comments, :ancestry
    
    # 3rd party
    create_table :friendly_id_slugs do |t|
      t.string   :slug,           :null => false
      t.integer  :sluggable_id,   :null => false
      t.string   :sluggable_type, :limit => 40
      t.datetime :created_at
    end
    
    add_index :friendly_id_slugs, :sluggable_id
    add_index :friendly_id_slugs, [:slug, :sluggable_type], :unique => true
    add_index :friendly_id_slugs, :sluggable_type
  end
  
  def down
    raise 'irreversable migration!'
  end
end