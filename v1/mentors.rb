require 'rubygems'
require 'pry'
require 'ruby-enum'

class Mentors
  include Ruby::Enum

  define 'JIO',     { mention: '@jiosotoyama',    calendar_name: 'じお',      birthday: '05/29' }
  define 'YUTA',    { mention: '@yuta-takahashi', calendar_name: 'ゆーた',     birthday: '08/19'}
  define 'YUKKI',   { mention: '@ueda-yukihiro',  calendar_name: 'ゆっきー',   birthday: '11/05' }
  define 'UMEKI',   { mention: '@ryo-umeki',      calendar_name: 'うめきち',   birthday: '10/15' }
  define 'SATSUKI', { mention: '@satsuki-kajiya', calendar_name: 'さつき',    birthday:  '05/21' }
  define 'MAKIY',   { mention: '@makiko-shimizu', calendar_name: 'まっきー',   birthday: '01/13'}
  define 'SAWA',    { mention: '@sawa-uchida',    calendar_name: 'さわっち',   birthday: '10/12'}
  define 'AWA',     { mention: '@keisuke.awa',    calendar_name: 'あわちゃん', birthday: '10/27' }
  define 'ANJU',    { mention: '@anju',           calendar_name: 'あんじゅ',   birthday: '01/13' }
  define 'MAI',     { mention: '@takana-mai',     calendar_name: 'まい',      birthday: '09/20'}

  def self.add_their_mentions_into(shifts)
    shifts_with_mentions = []
    self.values.each { |value|
      shifts.each { |shift|
        if shift[:calendar_name].include?(value[:calendar_name])
          shifts_with_mentions << value.merge(shift)
        end
      }
    }
    shifts_with_mentions
  end
end
