class BuildsController < ApplicationController
  require_authentication!
  enable_polling!

  # GET /builds
  # GET /builds.json
  def index
    if params[:page].present? and params[:page].to_i > 0
      @page = params[:page].to_i
    else
      @page = 1
    end
    @per_page = 10

    @builds = Build.newest_first_paginated(@page, @per_page).to_a

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @builds }
    end
  end

  # GET /builds/1
  # GET /builds/1.json
  def show
    @build = Build.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @build }
    end
  end

  # POST /builds
  # POST /builds.json
  def create
    @build = Build.new(params.require(:build).permit(:name, :ref))

    respond_to do |format|
      if @build.save
        format.html { redirect_to @build }
        format.json { render json: @build, status: :created, location: @build }
      else
        format.html { redirect_to({action: 'index'}, alert: "Errors creating your build: #{@build.errors.full_messages.join('; ')}") }
        format.json { render json: @build.errors, status: :unprocessable_entity }
      end
    end
  end

  def enqueue
    Resque.enqueue(Jobs::Builder, params[:id])
    redirect_to build_path(params[:id])
  end
end
