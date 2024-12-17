class DashboardController < ApplicationController
  before_action :authenticate_user!
 
  def index
    @salary_ranges = {
      "Até R$ 1.412,00" => [],
      "R$ 1.412,01 - R$ 2.666,68" => [],
      "R$ 2.666,69 - R$ 4.000,03" => [],
      "R$ 4.000,04 - R$ 7.786,02" => [],
      "Acima de R$ 7.786,02" => []
    }

    Proponent.all.each do |proponent|
      case proponent.salary
      when 0..1412.00
        @salary_ranges["Até R$ 1.412,00"] << proponent
      when 1412.01..2666.68
        @salary_ranges["R$ 1.412,01 - R$ 2.666,68"] << proponent
      when 2666.69..4000.03
        @salary_ranges["R$ 2.666,69 - R$ 4.000,03"] << proponent
      when 4000.04..7786.02
        @salary_ranges["R$ 4.000,04 - R$ 7.786,02"] << proponent
      else
        @salary_ranges["Acima de R$ 7.786,02"] << proponent
      end
    end

    @salary_counts = @salary_ranges.transform_values { |proponents| proponents.count }

    @chart_data = @salary_counts
  end
end
