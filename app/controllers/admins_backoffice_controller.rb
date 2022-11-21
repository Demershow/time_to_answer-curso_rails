class AdminsBackofficeController < ProfileController
  before_action :authenticate_admin!
    layout 'admins_backoffice'
end
