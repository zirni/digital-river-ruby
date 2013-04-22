require "spec_helper"

module DigitalRiver
  class Response
    describe Error do
      let(:status)    { 500 }
      let(:headers)   { Hash.new }
      let(:arguments) { [body, status, headers] }

      context ".build" do
        subject    { described_class.build(*arguments) }

        context "no structure" do
          let(:body) { Hash.new }

          its(:error_messages) { should include("code" => "not given", "description" => "not given") }
        end

        context "with hash response" do
          let(:body) do
            {"error"=>"invalid_client",
             "error_description"=>"Request Contains Invalid Client ID",
             "error_uri"=>"http://developers.digitalriver.com/oauth20/overview"}
          end

          its(:error_messages) { should include("code" => "invalid_client", "description" => "Request Contains Invalid Client ID") }
        end

        context "with nested structure" do
          let(:body) do
            {"errors" =>
             {"error"=>
              {"code" => "invalid_client",
               "description"=>"Request Contains Invalid Client ID",
               "relation"=>"http://developers.digitalriver.com/oauth20/overview"}
             }
            }
          end

          its(:error_messages) { should include("code" => "invalid_client", "description" => "Request Contains Invalid Client ID") }
        end

        context "with nested structure" do
          let(:body) do
             {"error"=>
              [
                {"code" => "invalid_client",
                 "description"=>"Request Contains Invalid Client ID",
                 "relation"=>"http://developers.digitalriver.com/oauth20/overview"}
              ]
             }
          end

          its(:error_messages) { should include("code" => "invalid_client", "description" => "Request Contains Invalid Client ID") }
        end

        context "XML system fault" do
          let(:body) do
            "<fault>\n            <faultstring>Service Identification Failure</faultstring>\n            <detail>\n                <errorcode>26108</errorcode>\n                    <trace>\n                        Fault Name: ServiceIdentificationFailure\n                        Error Type: NotFound\n                        Description: Service Identification Failure\n                        Service: null\n                        Endpoint: null\n                        Operation (Client):\n                    </trace>\n            </detail>\n</fault>\n"
          end

          its(:error_messages) { should include("code" => "26108", "description" => "Service Identification Failure") }
        end
      end
    end
  end
end
