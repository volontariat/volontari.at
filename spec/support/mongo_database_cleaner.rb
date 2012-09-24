class MongoDatabaseCleaner
  def self.clean
    Dir["#{Rails.root}/app/models/**/*.*"].each do |path_name|
      path_name.gsub!("#{Rails.root.to_s}/app/models/", '')
      path_name = path_name.split('/')
      klass = path_name.pop.sub(/\.rb$/,'').camelize
      
      unless path_name.none?
        klass = [path_name.map(&:camelize).join('::'), klass].join('::')
      end
      
      klass = klass.constantize
     
      next if klass.respond_to?(:table_name) || !klass.respond_to?(:delete_all)
      
      klass.delete_all
    end
  end
end