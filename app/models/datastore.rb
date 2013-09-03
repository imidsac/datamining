require 'csv'

class Datastore < ActiveRecord::Base
  has_many :lines

  #
  # Load datastore from CSV file.
  # @param  path [String] path to the file. Must be related to rails root.
  #
  # @return [Datastore] return the loaded datastore.
  def self.load(path)
    app_path = Rails.root.join(path)
    if File.exists?(app_path)
      ary     = CSV.read(app_path)
      headers = ary.shift
      store   = Datastore.create(path: path)

      ary.each do |cols|
        datas = Hash[headers.zip(cols)]
        store.lines.create data: datas
      end

      store
    else
      false
    end
  end


  #
  # Return duplicated lines of the store, base on the key.
  # @param  store [Datastore] Datastore to compare with
  # @param  key [String] Key for comparing value
  #
  # @return [Array] Lines
  def duplicated_lines(store, key)
    self.lines.inject([]) do |acc, line|
      value = line.data[key]
      acc << line if store.lines.where("data -> :key = :value", key: key, value: value).any?
      acc
    end
  end
end
