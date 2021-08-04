class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy #IMP PROB no dependent: :destroy here, because I don't wanna dele the tasks 
  # or maybe I do, like it's not specifically written in the zadani, but logically tasks shouldn't exist withou a project ... 
  
    # but still not sure how the many to many works with dependent: :destroy
    # try it out
end