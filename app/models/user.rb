# coding: utf-8
class User < ApplicationRecord
  has_one :user_detail

  def create_default(params)
  end

  def create_detail
    # transactional_create_detail
    transactional_create_detail_with_my_raise
    # transactional_create_detail_with_rescue
    # transactional_create_detail_with_rescue2
    # transactional_create_detail_with_rescue3
    # transactional_create_detail_with_uncatch
    puts "after function persisted? => #{persisted?}, id => #{id}"
  rescue => e
    puts "*after function on rescue* persisted? => #{persisted?}, id => #{id}, e => #{e.class}"
  end

  def transactional_create_detail
    puts __method__
    self.class.transaction do
      save_result = save
      puts "save result => #{save_result}"           # ここで保存して
      puts "persisted? => #{persisted?}, id = #{id}" #
      ud = UserDetail.create                         # ここで詳細を作成して
      return if ud.id.nil?                           # return で抜けたら、、、userはsaveされている？いない？
      puts '***** FINISH *****'
    end
  end

  def transactional_create_detail_with_my_raise
    puts __method__
    self.class.transaction do
      save_result = save
      puts "save result => #{save_result}"           # ここで保存して
      puts "persisted? => #{persisted?}, id = #{id}" #
      ud = UserDetail.create                         # ここで詳細を作成して
      raise 'UserDetail Save Failed' if ud.id.nil?                           # return で抜けたら、、、userはsaveされている？いない？
      puts '***** FINISH *****'
    end
  end


  def transactional_create_detail_with_rescue
    puts __method__
    self.class.transaction do
      save_result = save
      puts "save result = #{save_result}"          # ここで保存して
      puts "persisted = #{persisted?}, id = #{id}" #
      ud = UserDetail.create!                      # ここで詳細を作成して
      puts '***** FINISH *****'                    #
    rescue => e                                    # ここで例外を受け取ったら、、、userはsaveされている？いない？
      puts '***** RESCUE! *****'
      puts e
    end
  end

  def transactional_create_detail_with_rescue2
    puts __method__
    self.class.transaction do
      save_result = save
      puts "save result = #{save_result}"          # ここで保存して
      puts "persisted = #{persisted?}, id = #{id}" #
      ud = UserDetail.create!                      # ここで詳細を作成して
      puts '***** FINISH *****'
    end
  rescue => e                                      # transaction外で例外を受け取ったら、、、userはsaveされている？いない？
    puts '***** OVER RESCUE! *****'
    puts e
  end

  def transactional_create_detail_with_rescue3
    puts __method__
    self.class.transaction do
      save_result = save
      puts "save result = #{save_result}"          # ここで保存して
      puts "persisted = #{persisted?}, id = #{id}" #
      ud = UserDetail.create!                      # ここで詳細を作成して
      puts '***** FINISH *****'
    rescue => e                                    # ここで例外を受け取って投げて
      puts '***** RESCUE! *****'
      raise e
    end
  rescue => e                                      # ここで例外を受け取ったら、、、userはsaveされている？いない？
    puts '***** OVER RESCUE! *****'
    puts e
  end


  def transactional_create_detail_with_uncatch
    puts __method__
    self.class.transaction do
      save_result = save
      puts "save result = #{save_result}"          # ここで保存して
      puts "persisted = #{persisted?}, id = #{id}" #
      ud = UserDetail.create!                      # ここで詳細を作成して失敗して例外が飛んだらuserはsaveされている？いない？
    end
  end
end
