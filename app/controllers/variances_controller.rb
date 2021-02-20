class VariancesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @variances = Variance.all
  end

  def show
    @variance = Variance.find(params[:id])
    snapshots = @variance.product.snapshots
    @snapshot = snapshots.where(created_at: @variance.created_at.midnight..@variance.created_at.end_of_day).last
    index_snap = snapshots.index(@snapshot)

    @snapshot_past = snapshots[index_snap-1]
  end
end
