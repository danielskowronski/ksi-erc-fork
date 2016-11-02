class LockLogsController < ApplicationController
  layout "v3"

  # GET /lock_logs
  # GET /lock_logs.json
  def index
    @lock_logs = LockLog.all
  end
end
