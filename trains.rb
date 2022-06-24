# Train class
class Train
  attr_accessor :speed, :carriage
  attr_writer :current_station
  attr_reader :type, :route

  def initialize(type, speed = 0, carriage = 0)
    @type = type.downcase
    @speed = speed
    @carriage = carriage
  end

  def stop
    @speed = 0
  end

  def stopped?
    @speed.zero?
  end

  def increase_speed(amount)
    @speed += amount
  end

  def attach_carriage
    @carriage += 1 if stopped?
  end

  def detach_carriage
    @carriage -= 1 if stopped?
  end

  def route=(route)
    @route = route if route.is_a? Route
  end

  def current_station
    @current_station.name
  end

  def next_station
    @route.next_station(@current_station).name
  end

  def previous_station
    @route.previous_station(@current_station).name
  end

  def move_to_next_station
    @route.next_station(@current_station).park_train(self)
  end
  private :speed=, :carriage=
end

# Railway Station class
class RailwayStation
  attr_reader :name, :trains_list

  def initialize(name)
    @name = name.to_s.capitalize
    @trains_list = []
  end

  def park_train(train)
    @trains_list << train if train.is_a? Train
    train.current_station = self
  end

  def show_train_types
    @trains_list.map(&:type).tally
  end
end

# Route class
class Route
  attr_reader :route_map

  def initialize
    @route_map = []
  end

  def show_stations
    @route_map.map(&:name)
  end

  def add_station(station)
    @route_map << station if station.is_a? RailwayStation
  end

  def delete_station(station_index)
    @route_map.delete_at(station_index)
  end

  def next_station(station)
    @route_map[@route_map.index(station) + 1]
  end

  def previous_station(station)
    @route_map[@route_map.index(station) - 1]
  end
end
