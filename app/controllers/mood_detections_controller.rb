class MoodDetectionsController < ApplicationController
  before_action :set_mood_detection, only: %i[ show edit update destroy ]
  require "base64"
  require "mime/types"

  # GET /mood_detections or /mood_detections.json
  def index
    @mood_detections = MoodDetection.all
  end

  # GET /mood_detections/1 or /mood_detections/1.json
  def show
  end

  # GET /mood_detections/new
  def new
    @mood_detection = MoodDetection.new
  end

  # GET /mood_detections/1/edit
  def edit
  end

  # POST /mood_detections or /mood_detections.json
  def create
    @mood_detection = MoodDetection.new(mood_detection_params)

    if params[:captured_image].present?
      decoded_image = decode_base64_image(params[:captured_image])
      @mood_detection.image.attach(decoded_image)
    end

    respond_to do |format|
      if @mood_detection.save
        ProcessMoodDetectionJob.perform_later(@mood_detection.id)

        format.html { redirect_to @mood_detection, notice: "Mood detection was successfully created. Processing face match..." }
        format.json { render :show, status: :created, location: @mood_detection }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mood_detection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mood_detections/1 or /mood_detections/1.json
  def update
    respond_to do |format|
      if @mood_detection.update(mood_detection_params)
        format.html { redirect_to @mood_detection, notice: "Mood detection was successfully updated." }
        format.json { render :show, status: :ok, location: @mood_detection }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mood_detection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mood_detections/1 or /mood_detections/1.json
  def destroy
    @mood_detection.destroy!

    respond_to do |format|
      format.html { redirect_to mood_detections_path, status: :see_other, notice: "Mood detection was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def decode_base64_image(data)
    if data =~ /^data:(.*?);base64,(.*)$/
      content_type = Regexp.last_match(1)
      base64_data = Regexp.last_match(2)
      filename = "upload-#{Time.now.to_i}.#{mime_extension(content_type)}"
      decoded_data = Base64.decode64(base64_data)

      {
        io: StringIO.new(decoded_data),
        filename: filename,
        content_type: content_type,
      }
    end
  end

  def mime_extension(content_type)
    MIME::Types[content_type].first.preferred_extension
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_mood_detection
    @mood_detection = MoodDetection.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def mood_detection_params
    params.require(:mood_detection).permit(:user_name, :mood, :confidence, :image)
  end
end
