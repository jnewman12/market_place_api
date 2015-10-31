shared_examples "paginated list" do 
  it { json_response.should have_key(:meta) }
  it { json_response[:meta].should have_key(:pagination) }
  it { json_response[:meta][:pagination].should have_key(:per_page) }
  it { json_response[:meta][:pagination].should have_key(:total_pages) }
  it { json_response[:meta][:pagination].should have_key(:total_objects) }	
end