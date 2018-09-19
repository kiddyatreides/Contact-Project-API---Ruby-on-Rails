class HomeController < ApplicationController
    # Untuk skip check authentication semacam CSRF Token di Laravel
    skip_before_filter :verify_authenticity_token

    # Handling ketika data not found saat update, dan delete
    rescue_from ActiveRecord::RecordNotFound, with: :notFound
    
    # Method Get All Data
    def index
        @user = User.all
        
        render json: {
            values: @user,
            message: "Success!",
          }, status: 200   
    end

    # Method Insert
    def create
        @user = User.new(user_params)
 
        if @user.save
            render json: {
                values: "",
                message: "Success!",
              }, status: 200
        else
            render json: {
                values: "",
                message: "Failed!",
              }, status: 400
        end        
    end    

    # Method Get Data by ID User
    def show
        @user = User.find_by_id(params[:id])
        if @user.present?
            render json: {
                values: @user,
                message: "Success!",
              }, status: 200
        else
            render json: {
                values: "",
                message: "Empty!",
              }, status: 400
        end
    end

    # Method Update data
    def update
        @user = User.find(params[:id])
       
        if @user.update(user_params)
            render json: {
                values: {},
                message: "Success!",
              }, status: 200
        else
            render json: {
                values: {},
                message: "Faied!",
              }, status: 400
        end
    end

    # Method Delete Data
    def destroy
        @user = User.find(params[:id])
        
        if @user.destroy
            render json: {
                values: {},
                message: "Success!",
              }, status: 200
        else
            render json: {
                values: {},
                message: "Failed!",
              }, status: 400
        end
    end
  
    # Extra method yang dibutuhkan sesuai kebutuhan
    private

        # Method yang digunakan untuk inisialisasi
        #  data saat dimasukkan kedalam database
        def user_params
            params.permit(:name, :phone)
        end

        # Method untuk handling not found data untuk Rescue handling diatas
        def notFound
            render json: {
                values: {},
                message: "Data Not Found!",
              }, status: 400
        end 
end
