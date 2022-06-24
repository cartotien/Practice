# Train class
class Train
  attr_accessor :speed, :carriage, :current_station, :route
  attr_reader :type

  def initialize(type, speed = 0, carriage = 0)
    @type = type.downcase
    self.speed = speed
    self.carriage = carriage
  end

  def stop
    self.speed = 0
  end

  def stopped?
    @speed.zero?
  end

  def increase_speed(amount)
    self.speed += amount
  end

  def attach_carriage
    self.carriage += 1 if stopped?
  end

  def detach_carriage
    self.carriage -= 1 if stopped?
  end

  def get_route(route)
    @route = route if route.is_a? Route
  end

  def next_station
    @route.route_map[@route.route_map.index(@current_station) + 1].name
  end

  def previous_station
    @route.route_map[@route.route_map.index(@current_station) - 1].name
  end

  def move_to_next_station
    @route.route_map[@route.route_map.index(@current_station) + 1].get_train(self)
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

  def get_train(train)
    @trains_list << train if train.is_a? Train
    train.current_station = self
  end

  def show_train_types
    train_type_list = []
    @trains_list.each { |train| train_type_list << train.type }
    train_type_list.tally
  end
end

# Route class
class Route
  attr_reader :route_map

  def initialize
    @route_map = []
  end

  def show_stations
    station_list = []
    @route_map.each { |station| station_list << station.name }
    station_list
  end

  def add_station(station)
    @route_map << station if station.is_a? RailwayStation
  end

  def delete_station(station_number)
    @route_map.delete_at(station_number)
  end
end
