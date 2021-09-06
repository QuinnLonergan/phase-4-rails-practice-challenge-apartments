class LeasesController < ApplicationController
    wrap_parameters format: []
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def create
        lease = Lease.create!(lease_params)
        render json: lease
    rescue ActiveRecord::RecordInvalid => e
        render json: {errors: e.record.errors.full_messages}
    end

    def destroy
        lease = find_lease
        lease.destroy
        head :no_content
    end

    private

    def render_not_found_response
        render json: { errors: "Lease not found"}
    end

    def lease_params
        params.permit(:apartment_id, :tenant_id)
    end

    def find_lease
        Lease.find(params[:id])
    end
end
