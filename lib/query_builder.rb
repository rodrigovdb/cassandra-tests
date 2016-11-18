# frozen_string_literal: true

class QueryBuilder
  attr_reader :query

  def initialize(item)
    @item = item

    assemble_query
  end

  private

  def assemble_query
    @query = "#{assemble_insert} #{assemble_values}"
  end

  def assemble_insert
    query  = "INSERT INTO roydashes_stash(id, title, dur, num, vol, ex, aId, aNm, tbId, tbNm, img, als, prev, "
    query += "st, str, right, md, lab, p, fUd, ma, rnk, tasort, rtId, rrId)"
  end

  def assemble_values
    query  = ' VALUES ('
    query += "#{assemble_part1}, { #{assemble_st} }, #{assemble_part2},{ #{assemble_lab} }, #{assemble_part3}"
    query += ');'

    query
  end

  def assemble_part1
    query  = "#{@item['_id']}, '#{@item['title']}', #{@item['dur']}, #{@item['num']}, #{@item['vol']}, "
    query += "#{@item['ex']}, #{@item['aId']}, '#{@item['aNm']}', #{@item['tbId']}, '#{@item['tbNm']}', "
    query += "'#{@item['img']}', '#{@item['als']}', '#{@item['prev']}'"

    query
  end

  def assemble_st
    query = ''

    @item['st'].each do |i|
      query += "{ id: #{i['id']}, ctry: '#{i['ctry']}', en: '#{i['en']}', "
      query += "st: '#{i['st']}', stdt: { date: '#{i['stDt']['$date']}' }, "
      query += "defaultSt: #{i['defaultSt']} }"
    end

    query
  end

  def assemble_part2
    "#{@item['str']}, #{@item['right']}, '#{@item['md']}'"
  end

  def assemble_lab
    query = ''

    @item['lab'].each do |i|
      query += "{ id: #{i['id']}, ctry: '#{i['ctry']}', "
      query += "nm: '#{i['nm']}', p: '#{i['p']}' }"
    end

    query
  end

  def assemble_part3
    query  = "#{@item['p']}, { date: '#{@item['fUd']['$date']}' }, #{@item['ma']}, #{@item['rnk']}, "
    query += "#{@item['tasort']}, '#{@item['rtId']}', '#{@item['rrId']}'"

    query
  end
end
