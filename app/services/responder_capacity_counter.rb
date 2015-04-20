# Returns an Hash of sums of capacity for responders
#
# key: kind of Emergency
# total: sum of capacity from all responders
# avalible: sum of capacity of responders that are avalible (not assigned to any emergency)
# on_duty: sum of capacity of responders that are on duty
# avalible_and_on_duty: sum of capacity of respoders that are both avalible and on duty
class ResponderCapacityCounter
  def initialize(responders)
    @responders = responders.group_by(&:type).flat_map do |rsp|
      parts = get_parts_for_capacity rsp[1]
      [rsp[0].to_sym, [parts[:total], parts[:avalible], parts[:on_duty], parts[:avalible_and_on_duty]]]
    end
  end

  def counter
    Hash[*@responders]
  end

  private

  # Returns an Hash of sums of capacity for responders
  #
  # total: sum of capacity from all responders
  # avalible: sum of capacity of responders that are avalible (not assigned to any emergency)
  # on_duty: sum of capacity of responders that are on duty
  # avalible_and_on_duty: sum of capacity of respoders that are both avalible and on duty
  def get_parts_for_capacity(rsp)
    {
      total: count_isolated_responders(rsp) { true },
      avalible: count_isolated_responders(rsp) { |h| h[:emergency_code].nil? },
      on_duty: count_isolated_responders(rsp) { |h| h[:on_duty] == true },
      avalible_and_on_duty: count_isolated_responders(rsp) do |h|
        h[:on_duty] == true && !h[:emergency_code]
      end
    }
  end

  # Converts an Array of Responders into a sum of capacity based on &izolation block used
  # for select
  def count_isolated_responders(responders, &izolation)
    responders.select { |r| izolation.call(r) }.map { |h| h[:capacity] }.sum || 0
  end
end
