
#require './lib/tamayo/tamayocompute.rb'

ORDERS = [20, 20, 20, 20, 20, 10, 20, 10, 20, 30, 30, 10, 30, 20, 10, 30, 10, 10, 10, 10, 10, 10, 10, 20, 30, 20, 10, 20, 10, 10, 30 , 50, 20]

class EnterprisesController < ApplicationController
  before_action :find_enterprise, :find_game_session, :get_game_decisions
  # todo gamedecisions, current_day

  def show
    @all_enterprises = Enterprise.all
    @gamedecision = GameDecision.new
    @previous_game_decision = GameDecision.where(enterprise_id: @enterprise).last
    @current_day = @gamesession.current_day

# PRODUCTION VARIABLES
    @today_orders_received = ORDERS[@current_day]
    @current_number_of_employees = @enterprise.current_number_of_employees
    @today_workshop_production_capacity = @enterprise.today_workshop_production_capacity
    # @backlog_from_previous_day = @enterprise.backlog_from_previous_day(@previous_game_decision)
    @current_backlog = @enterprise.current_backlog
    @total_to_produce_today = @enterprise.total_to_produce_today(@today_orders_received, @current_backlog)

# COSTS VARIABLES =>Test for the 4 variables: OK
    @cost_of_salaries_for_today = @enterprise.cost_of_salaries_for_today
    @cost_of_raw_materials_for_today = @enterprise.cost_of_raw_materials_for_today(@today_orders_received)
    @cost_of_hiring_and_firing_for_today = @enterprise.cost_of_hiring_and_firing_for_today(@gamedecisions.last.employees_variation)
    @total_money_spent_today = @cost_of_salaries_for_today + @cost_of_raw_materials_for_today + @cost_of_hiring_and_firing_for_today
# TREASURY VARIABLES



# SALES VARIABLES

  end

  # ------Methods for before action---------
  def find_enterprise
    @enterprise = Enterprise.find(params[:id])
  end

  def find_game_session
    @gamesession = GameSession.find(@enterprise.game_session_id)
  end

  def get_game_decisions
    @gamedecisions = GameDecision.where(enterprise_id: @enterprise)
  end
  # /----------------------------------------
end
