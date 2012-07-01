class LicensesController < ApplicationController
  # GET /licenses
  # GET /licenses.xml
  def index
    @licenses = License.order(:name)
    respond_with(@licenses)
  end

  # GET /licenses/1
  # GET /licenses/1.xml
  def show
    @license = License.find(params[:id])
    respond_with(@license)
  end

  # GET /licenses/new
  # GET /licenses/new.xml
  def new
    @license = License.new
    respond_with(@license)
  end

  # GET /licenses/1/edit
  def edit
    @license = License.find(params[:id])
  end

  # POST /licenses
  # POST /licenses.xml
  def create
    @license = License.new(params[:license])
    @license.save
    respond_with(@license)
  end

  # PUT /licenses/1
  # PUT /licenses/1.xml
  def update
    @license = License.find(params[:id])
    @license.update_attributes(params[:license])
    respond_with(@license, :location => licenses_path)
  end

  # DELETE /licenses/1
  # DELETE /licenses/1.xml
  def destroy
    @license = License.find(params[:id])
    @license.destroy
    respond_with(@license)
  end
end
