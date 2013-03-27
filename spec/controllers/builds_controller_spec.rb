require 'spec_helper'

describe BuildsController do
  let(:valid_attributes)  { { "name" => "Name", "ref" => "Ref"  } }
  let(:valid_session)     { { "authenticated" => true } }

  before do
  end

  describe "GET index" do
    it "assigns all builds as @builds" do
      build = Build.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:builds)).to eq([build])
    end
  end

  describe "GET show" do
    it "assigns the requested build as @build" do
      build = Build.create! valid_attributes
      get :show, {:id => build.to_param}, valid_session
      expect(assigns(:build)).to eq(build)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Build" do
        expect {
          post :create, {:build => valid_attributes}, valid_session
        }.to change(Build, :count).by(1)
      end

      it "assigns a newly created build as @build" do
        post :create, {:build => valid_attributes}, valid_session
        expect(assigns(:build)).to be_a(Build)
        expect(assigns(:build)).to be_persisted
      end

      it "redirects to the created build" do
        post :create, {:build => valid_attributes}, valid_session
        expect(response).to redirect_to(Build.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved build as @build" do
        # Trigger the behavior that occurs when invalid params are submitted
        Build.any_instance.stub(:save).and_return(false)
        post :create, {:build => { "name" => "invalid value" }}, valid_session
        expect(assigns(:build)).to be_a_new(Build)
      end

      it "redirects to 'index' action with an alert" do
        # Trigger the behavior that occurs when invalid params are submitted
        Build.any_instance.stub(:save).and_return(false)
        post :create, {:build => { "name" => "invalid value" }}, valid_session
        expect(response).to redirect_to(builds_path)
        expect(flash[:alert]).to_not be_nil
      end
    end
  end

end
