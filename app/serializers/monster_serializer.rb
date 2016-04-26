class MonsterSerializer < ActiveModel::Serializer
  attributes :id, :name, :power, :type
end
