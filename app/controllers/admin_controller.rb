require 'blacklist'
class AdminController < ApplicationController
  before_action :setup_blacklist
  before_action :authenticate_admin!

  def index
    @list = @black_list.all_banned_ip
    @user_ips = User.all
    render 'admin/admin'
  end

  def block_ip
    if @black_list.is_blacklisted? params[:ip_addresses]
      flash[:error] = "IP: #{ip} has been already banned"
    else
      ips = request.params[:ip_addresses]
      @black_list.add_ip(ips)
      @black_list.save_list
    end
    redirect_to :action => 'index'
  end

  def unblock_ip
    @black_list.all_banned_ip.each do |banned_ip|
      if banned_ip.include? params[:ip_addresses].strip
          @black_list.remove_ip banned_ip
          @black_list.save_list
        end
      end
    redirect_to :action => 'index'
  end

  def setup_blacklist
    @black_list = Blacklist.new true
  end



end
