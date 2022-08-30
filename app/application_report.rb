require 'json'
require 'time'
# ApplicationReport class
class ApplicationReport
  def initialize(json_filename)
    @file = File.read(json_filename)
  end

  def retrieve_trend(channel = 'all')
    @channel = channel
    store_data
    hash_store_compute
  end

  def check_count(channel = 'all')
    @channel = channel
    all_applications.size
  end

  private

  def hash_store_compute
    array_store.each do |a|
      a[1] = (a[2].size / 3.to_f).round
      a[2] = nil
      a.compact!
    end
    array_store.to_h
  end

  def store_data
    all_applications.each do |ap|
      array_store[Time.parse(ap['timestamp']).hour][2] << Time.parse(ap['timestamp']).day
    end
  end

  def all_applications
    data_hash = JSON.parse(@file)
    if @channel.empty? || @channel == 'all'
      data_hash['applications']
    else
      data_hash['applications'].select { |k| k['channel'] == @channel }
    end
  end

  def twenty_four_hours
    skeleton = []
    (0..23).each do |hour|
      skeleton << [hour, 0, []]
    end
    skeleton
  end

  def array_store
    @array_store ||= twenty_four_hours
  end
end
