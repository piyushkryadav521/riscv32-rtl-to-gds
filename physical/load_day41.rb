include RBA

def_path = File.expand_path("physical/rv32i_cts_opt.def")
image_path = File.expand_path("images/day41_post_cts.png")

options = RBA::LoadLayoutOptions.new
lefdef = RBA::LEFDEFReaderConfiguration.new

lefdef.lef_files = [
  File.expand_path("~/OpenROAD/test/Nangate45/Nangate45_tech.lef"),
  File.expand_path("~/OpenROAD/test/Nangate45/Nangate45.lef")
]

lefdef.read_lef_with_def = false
lefdef.macro_resolution_mode = 1

options.lefdef_config = lefdef

mw = RBA::Application.instance.main_window
mw.load_layout(def_path, options, 1)

view = mw.current_view
view.max_hier
view.zoom_fit

view.save_image(image_path, 1600, 1200)

puts "Layout loaded successfully"
puts "Image saved: #{image_path}"
