class Sub < ApplicationRecord
    validates :title, :description, presence: true 

    

    belongs_to :moderator, 
        class_name: :User,
        foreign_key: :user_id 



    has_many :post_subs,
        foreign_key: :post_id, 
        class_name: :PostSub
        
    has_many :posts,
        through: :post_subs,
        source: :post

    

    
end
