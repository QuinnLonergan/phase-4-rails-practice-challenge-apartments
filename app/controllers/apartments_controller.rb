class ApartmentsController < ApplicationController
    wrap_parameters format: []
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        apartments = Apartment.all 
        render json: apartments
    end

    def show
        apartment = find_apartment
        render json: apartment
    end

    def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment
    rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.full_messages}
    end

    def update
        apartment = find_apartment
        apartment.update(apartment_params)
        render json: apartment
    end

    def destroy 
        apartment = find_apartment
        apartment.destroy
        head :no_content
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def find_apartment
        Apartment.find(params[:id])
    end

    def render_not_found_response
        render json: { error: "Apartment not found" }, status: :not_found
    end
end
