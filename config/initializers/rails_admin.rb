RailsAdmin.config do |config|

  config.included_models = %w(Event Group)

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ActiveRecord::Base.descendants.each do |imodel|
    config.model "#{imodel.name}" do
      list do
        exclude_fields :created_at, :updated_at
      end
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    #export
    # bulk_delete
    show
    edit
    delete
    #show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'Event' do
    edit do
      field :name
      field :url
      field :description
      field :status
      field :start_time
      field :end_time
    end

    list do
      scopes [:all_events, :this_week, :this_month, :disabled]

      field :name do
        filterable false

        pretty_value do
          bindings[:view].link_to(value, bindings[:object].url, target: '_blank')
        end
      end
      field :start_time do
        filterable false

        formatted_value do
          value.strftime('%I:%M %p, %d %B %Y')
        end
      end
      field :group do
        filterable false
      end
    end
  end

  config.model 'Group' do
    edit do
      configure :events do
        hide
      end

      field :external_id do
        label do 'External id' end
      end
      field :name
      field :url
      field :status
    end

    list do
      scopes [:all_groups, :disabled]

      field :name do
        filterable false

        pretty_value do
          bindings[:view].link_to(value, bindings[:object].url, target: '_blank')
        end
      end

      field :status do
        filterable false

        pretty_value do
          Group.statuses.keys[value].titleize
        end
      end
    end
  end
end
