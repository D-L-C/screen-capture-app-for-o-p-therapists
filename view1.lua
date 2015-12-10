-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------
local widget = require("widget")
local composer = require( "composer" )

-- local storyboard= require("storyboard") 
local widget_newTextField = require("widget_newTextField") -- calls the non native text space 

local scene = composer.newScene()

display.setStatusBar( display.HiddenStatusBar ) 

local LEFT_PADDING = 10
local halfW = display.contentCenterX
local halfH = display.contentCenterY
display.setDefault( "background", 255/255 )

local widgetGroup = display.newGroup()

local function onSecondView( event )
composer.gotoScene( "view2" )
composer.tabBar:setSelected( 2, true )

end

local pushButton
local titleGradient = {
	type = 'gradient',
	color1 = { 189/255, 203/255, 220/255, 255/255 }, 
	color2 = { 89/255, 116/255, 152/255, 255/255 },
	direction = "down"
}
 local path = system.pathForFile( "data.txt", system.DocumentsDirectory )

-- Create toolbar to go at the top of the screen
local titleBar = display.newRect( halfW, 0, display.contentWidth, 32 )
titleBar:setFillColor( titleGradient )
titleBar.y = display.screenOriginY + titleBar.contentHeight * 0.5

-- create embossed text to go on toolbar
local titleText = display.newEmbossedText( "My List", halfW, titleBar.y, native.systemFontBold, 20 )

-- create a shadow underneath the titlebar (for a nice touch)
local shadow = display.newImage( "shadow.png" )
shadow.anchorX = 0.0	-- TopLeft anchor points
shadow.anchorY = 0.0
shadow.x, shadow.y = 0, titleBar.y + titleBar.contentHeight * 0.5
shadow.xScale = 620 / shadow.contentWidth
shadow.alpha = 0.45
-- setting up input text widget 
--Text to show which item we selected
local itemSelected = display.newText( "  ", 0, 0, native.systemFontBold, 28 )
itemSelected:setFillColor( 0 )
itemSelected.x = display.contentWidth + itemSelected.contentWidth * 0.5
itemSelected.y = display.contentCenterY
widgetGroup:insert( itemSelected )

local itemHomeHealthAgency = display.newText( " ", 0, 0, native.systemFontBold, 28 )
itemHomeHealthAgency:setFillColor( 0 )
itemHomeHealthAgency.x = display.contentWidth + itemHomeHealthAgency.contentWidth * 0.5
itemHomeHealthAgency.y = display.contentCenterY 
widgetGroup:insert( itemHomeHealthAgency )
-- Forward reference for our back button & tableview



local itemPatient_Name = display.newText( "  ", 0, 0, native.systemFontBold, 28 )
itemPatient_Name:setFillColor( 0 )
itemPatient_Name.x = display.contentWidth + itemPatient_Name.contentWidth * 0.5
itemPatient_Name.y = display.contentCenterY 
widgetGroup:insert( itemPatient_Name )

local itemTherapist_Name = display.newText( "  ", 0, 0, native.systemFontBold, 28 )
itemTherapist_Name:setFillColor( 0 )
itemTherapist_Name.x = display.contentWidth + itemTherapist_Name.contentWidth * 0.5
itemTherapist_Name.y = display.contentCenterY 
widgetGroup:insert(itemTherapist_Name)

 

 
local itemAuthorized_signatory_name = display.newText( "  ", 0, 0, native.systemFontBold, 28 )
itemAuthorized_signatory_name:setFillColor( 0 )
itemAuthorized_signatory_name.x = display.contentWidth + itemAuthorized_signatory_name.contentWidth * 0.5
itemAuthorized_signatory_name.y = display.contentCenterY 
widgetGroup:insert(itemAuthorized_signatory_name)

local itemauthorized_signatory_relationship = display.newText( "  ", 0, 0, native.systemFontBold, 28 )
itemauthorized_signatory_relationship:setFillColor( 0 )
itemauthorized_signatory_relationship.x = display.contentWidth + itemauthorized_signatory_relationship.contentWidth * 0.5
itemauthorized_signatory_relationship.y = display.contentCenterY 
widgetGroup:insert(itemauthorized_signatory_relationship)
function doesFileExist( fname, path )

    local results = false

    local filePath = system.pathForFile( fname, path )

    --filePath will be 'nil' if file doesn't exist and the path is 'system.ResourceDirectory'
    if ( filePath ) then
        filePath = io.open( filePath, "r" )
    end

    if ( filePath ) then
        print( "File found: " .. fname )
        --clean up file handles
        filePath:close()
        results = true
    else
        print( "File does not exist: " .. fname )
    end

    return results
end

	


local backButton, list



local function textListener( event )

    if ( event.phase == "began" ) then

        -- user begins editing text field
      print( "Begin editing", event.target.text )

    elseif ( event.phase == "ended" ) then

        -- text field loses focus

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
  

			print( event.target.text )

        -- do something with defaultField's text

    elseif ( event.phase == "editing" ) then

        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )
		native.setKeyboardFocus( textField )

    end
end

	local Patient_Name
	local HomeHealthAgency
	local Therapist_Name
	local authorized_signatory_name
	local authorized_signatory_relationship
	
	-- Handle press events for the checkbox
-- local function onSwitchPress( event )
    -- local switch = event.target
    -- print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
-- end

	local results = doesFileExist("/screen_cap_images4".."/".. "screenscapper.png", system.DocumentsDirectory )
local sigImage = display.newImage() 
 local saveData = "My app state data"
local path = system.pathForFile( "myfile.txt", system.DocumentsDirectory )


local file = io.open( path, "w+" )
file:write( saveData )
io.close( file )


--Include sqlite
require "sqlite3"
--Open data.db.  If the file doesn't exist it will be created
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open(path);
--Handle the applicationExit event to close the db

-- local dropQuery=[[DROP TABLE IF EXISTS tabletest]]
-- db:exec(dropQuery)

local tablesetup=[[ CREATE TABLE IF NOT EXISTS tabletest ( Id INTEGER UNIQUE , name, userinput);]]
db:exec(tablesetup)



local fieldTable={
	{name="Home Health Agency ",userinput="need data "},
	{name="Patient Name ",userinput="need data "},
	{name="Therapist Name ",userinput="need data "},
	{name="Authorized Signatory Name ",userinput="need data "},
	{name="Authorized Signatory Relationship ",userinput="need data "},
	{name="Time ",userinput="need data "},
	{name="Date ",userinput="need data "},
	{name="Types of Visits ",userinput="need data "},
	{name="Functional Reassessment ",userinput="need data "},
}
	
	
for i =1,#fieldTable do
	print (i,fieldTable[i].name,fieldTable[i].userinput);
 --local insertQuery = [[INSERT INTO tabletest VALUES (NULL, 'John Doe','This is an unknown person.');]]
 local insertQuery = [[INSERT INTO tabletest VALUES (]]..i..[[, ']] .. fieldTable[i].name  .. [[',']] .. fieldTable[i].userinput.. [['); ]]
	db:exec(insertQuery)
end


 
  --print rows?

 
print( "version " .. sqlite3.version() )

    require "sqlite3"
   local path = system.pathForFile( "data.db", system.DocumentsDirectory )
 local db = sqlite3.open( path )

 
  for row in db:nrows("SELECT * FROM tabletest") do
	print("Id "..row.Id.."".." Select op: "..row.name.. " Data "..row.userinput)
	
	-- create table at next available array index

	
	
  end


function scene:create( event )
	



	local sceneGroup = self.view
	-- set up actual text field 
	HomeHealthAgency = native.newTextField( 700, 550, 180, 30 )
HomeHealthAgency.placeholder ="Home Health Agency"
HomeHealthAgency:addEventListener( "userInput", textListener )

Patient_Name= native.newTextField(  HomeHealthAgency.x, HomeHealthAgency.y, HomeHealthAgency.width, HomeHealthAgency.height )
Patient_Name.placeholder="Patient Name"
Patient_Name:addEventListener( "userInput", textListener )
Therapist_Name = native.newTextField( HomeHealthAgency.x, HomeHealthAgency.y, HomeHealthAgency.width, HomeHealthAgency.height )
Therapist_Name.placeholder="Therapist Name"

Therapist_Name:addEventListener( "userInput", textListener )


authorized_signatory_name=native.newTextField(  HomeHealthAgency.x, HomeHealthAgency.y, HomeHealthAgency.width, HomeHealthAgency.height )
authorized_signatory_name:addEventListener( "userInput", textListener)
authorized_signatory_name.placeholder="Authorized Signatory name"
authorized_signatory_relationship=native.newTextField(  HomeHealthAgency.x, HomeHealthAgency.y, HomeHealthAgency.width, HomeHealthAgency.height )
authorized_signatory_relationship:addEventListener( "userInput", textListener)
authorized_signatory_relationship.placeholder="Authorized Signatory name"
	-- creating a table to control the list and the structure 

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create a white background to fill screen
	local bg = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	bg.anchorX = 0
	bg.anchorY = 0
	bg:setFillColor( 1 )	-- white
	
	-- create some text
	-- local title = display.newText( "First View", 0, 0, native.systemFont, 32 )
	-- title:setFillColor( 0 )	-- black
	-- title.x = display.contentWidth * 0.5
	-- title.y = 125
	
	-- local summary = display.newText( "Loaded by the first tab 'onPress' listener\n— specified in the 'tabButtons' table.", 0, 0, 292, 292, native.systemFont, 14 )
	-- summary:setFillColor( 0 ) -- black
	-- summary.x = display.contentWidth * 0.5 + 10
	-- summary.y = title.y + 215
		
		
	
	-- Create the widget
 -- checkboxButton = widget.newSwitch
-- {  
	-- x = 500,
    -- y = 140,
	
    -- style = "checkbox",
    -- id = "Checkbox",

    -- onPress = onSwitchPress
-- }
	local pushButton = widget.newButton{
	label = "Push me!",
	fontSize = 16,

	x = 80,
    y = 90,
	labelColor = 
	{ 

	default = { 0 }, 
	},
	emboss = false,
	onRelease = onSecondView,

	}
	
-- The "onRowRender" function may go here (see example under "Inserting Rows", above)
-- local function onRowRender( event )

    -- -- Get reference to the row group
    -- local row = event.row
	-- local id =row.index
    -- -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
    -- local rowHeight = row.contentHeight
    -- local rowWidth = row.contentWidth

    -- local rowTitle = display.newText( fieldTable[id].name,12, 0, native.systemFontBold, 18,fieldTable[id].txt)
    -- rowTitle:setFillColor( 0 )

    -- -- Align the label left and vertically centered
    -- rowTitle.anchorX = 0
    -- rowTitle.x = 2
    -- rowTitle.y = rowHeight * 0.5
	 -- row:insert( rowTitle)
	 
	 
	 
-- end
-- Create image sheet for custom scroll bar
local scrollBarOpt = {
    width = 20,
    height = 20,
    numFrames = 3,
    sheetContentWidth = 20,
    sheetContentHeight = 60
}

-- local tableView = widget.newTableView
-- {
    -- left = 200,
    -- top = 150,
    -- height = 330,
    -- width = 300,
    -- onRowRender = onRowRender,
    -- onRowTouch = onRowTouch,
    -- listener = scrollListener,
    -- scrollBarOptions = {
        -- topFrame = 1,
        -- middleFrame = 2,
        -- bottomFrame = 3
    -- }
-- }
-- for x = 1, #fieldTable do 

    -- -- Insert a row into the tableView
    -- tableView:insertRow(
        -- {
            -- isCategory = false,
            -- rowHeight = 36,
            -- rowColor = { default={ 1, 1, 1 }, over={ 1, 0.5, 0, 0.2 } },
            -- lineColor = { 0.5, 0.5, 0.5 }
			
        -- }
		
    -- )
	-- end
	
-- Handle row rendering
local function onRowRender( event )
	local phase = event.phase
	local row = event.row
	local id =row.index
	-- in graphics 2.0, the group contentWidth / contentHeight are initially 0, and expand once elements are inserted into the group.
	-- in order to use contentHeight properly, we cache the variable before inserting objects into the group

	local groupContentHeight = row.contentHeight

	local rowTitle = display.newText( row, "List item " .. fieldTable[id].name, 12, 0, native.systemFontBold, 16 )

	-- in Graphics 2.0, the row.x is the center of the row, no longer the top left.
	rowTitle.x = LEFT_PADDING

	-- we also set the anchorX of the text to 0, so the object is x-anchored at the left
	rowTitle.anchorX = 0

	rowTitle.y = groupContentHeight * 0.5
	rowTitle:setFillColor( 0, 0, 0 )
	
	local rowArrow = display.newImage( row, "rowArrow.png", false )

	rowArrow.x = row.contentWidth - LEFT_PADDING

	-- we set the image anchorX to 1, so the object is x-anchored at the right
	rowArrow.anchorX = 1
	rowArrow.y = groupContentHeight * 0.5
end


-- picker info for days and years 
local days = {}
	local years = {}

	for i = 1, 31 do
		days[i] = i
	end

	for i = 1, 10 do
		years[i] = 2012 + i
	end
	--months days and years
	local columnData = 
	{ 
		{ 
			align = "right",
			width = 110,
			startIndex = 1,
			labels = 
			{
				"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" 
			},
		},

		{
			align = "center",
			width = 40,
			startIndex = 18,
			labels = days,
		},

		{
			align = "right",
			width = 65,
			startIndex = 10,
			labels = years,
		},
	}
--picker info for time hours and mintues 
	local hours = {}
	local minutes = {}

	for i = 1, 12 do
		hours[i] = i
	end

	for i = 1, 59 do
		minutes[i] = 0 + i
	end
	--am pm, minutes, hours 
	local columnfortimeData = 
	{ 
		{ 
			align = "right",
			width = 110,
			startIndex = 1,
			labels = 
			{
				"AM", "PM",
			},
		},

		{
			align = "center",
			width = 40,
			startIndex = 1,
			labels = hours,
		},

		{
			align = "right",
			width = 55,
			startIndex = 10,
			labels = minutes,
		},
	}
	
	-- piecker wheel for types of vist 
	local vistData = 
	{ 
	
	{ 
			align = "right",
			width = 110,
			startIndex = 1,
			labels = 
			{
				"Interim Evaluation", "Follow up", "ROC" ,"DC", "Other"
			},
		},
	
	}
	--picker info for functional reassessment 
	local reassessmentData = 
	{ 
	
	{ 
			align = "right",
			width = 110,
			startIndex = 1,
			labels = 
			{
				"13th", "19th", "30th" , "Other"
			},
		},
	
	}
--actucal picker set up y = top, x =left 
-- picker wheel for time
	local pickerWheelfortime = widget.newPickerWheel
	{
		top = display.contentHeight - 567,
		columns = columnfortimeData,
		left=620
	}
	
			-- Create a new Picker Wheel for date 
	local pickerWheelfordate = widget.newPickerWheel
	{
		top = display.contentHeight - 567,
		columns = columnData,
		left=620
	}
	-- type of vist 
	local typeofvistpicker = widget.newPickerWheel
	{
		top = display.contentHeight - 567,
		columns = vistData,
		left=620
	}
	--reassessment wheel
	local reassessmentpicker = widget.newPickerWheel
	{
		top = display.contentHeight - 567,
		columns = reassessmentData,
		left=620
	}
	

	


-- Hande row touch events
local function onRowTouch( event )
	local phase = event.phase
	local row = event.target
	local id =row.index
	if "press" == phase then
		print( "Pressed row: " .. fieldTable[id].name)





		

	elseif "release" == phase then
		--io.flush()
		-- Update the item selected text	
		-- finds id of the table based on the table is 
		if id==1 then
		-- enables the transition for HomeHealthAgency 
		itemHomeHealthAgency = HomeHealthAgency
		 itemSelected.text = "You selected " ..  fieldTable[id].name
		 io.write(  itemSelected.text)
		local transitionitemHomeHealthAgency= transition.to( itemHomeHealthAgency, { x = display.contentCenterX, time = 400, transition = easing.outExpo } )
			
		elseif id==2 then
		-- enables the transition for Patient_Name 
		itemSelected.text = "You selected " ..  fieldTable[id].name
		 io.write(itemSelected.text)
		  
			itemPatient_Name = Patient_Name
			io.write(itemPatient_Name.text)
			local transitionitemPatient_Name= transition.to( 	itemPatient_Name, { x = display.contentCenterX, time = 400, transition = easing.outExpo } )

		elseif id==3 then
				-- enables the transition for Therapist_Name 
		itemSelected.text = "You selected " ..  fieldTable[id].name
		itemTherapist_Name=Therapist_Name
		 io.write(  itemSelected.text)
		 print(itemSelected.text)
		 
		-- local reassessmentToDB=[[UPDATE tabletest SET userinput=']].."Functional Reassessment: "..reassessment..[[' WHERE id=9;]]
		 -- db:exec(reassessmentToDB)
		
			local transitionitemTherapist_Name= transition.to( 	itemTherapist_Name, { x = display.contentCenterX, time = 400, transition = easing.outExpo } )
		elseif id==4 then 
			-- enables the transition for Authorized_signatory_name 
		itemSelected.text = "You selected " ..  fieldTable[id].name
		itemAuthorized_signatory_name=authorized_signatory_name
			 io.write(  itemSelected.text)
		local transitionitemAuthorized_signatory_name=	transition.to( 	itemAuthorized_signatory_name, { x = display.contentCenterX, time = 400, transition = easing.outExpo } )
	sigImage=display.newImage("/screen_cap_images4".."/".. "screenscapper.png", system.DocumentsDirectory, 900, 300 ) 
		local transitionsigImage= transition.to( 	sigImage, { x = 300, time = 400, transition = easing.outExpo } )
		
		elseif id==5 then
		-- enables the transition for authorized_signatory_relationship 

		itemSelected.text = "You selected " ..  fieldTable[id].name
		itemauthorized_signatory_relationship=authorized_signatory_relationship
		local transitionitemauthorized_signatory_relationship= transition.to( itemauthorized_signatory_relationship, { x = display.contentCenterX, time = 400, transition = easing.outExpo } )
		elseif id==6 then
		-- enables the transition for pickerWheelfortime 
		itemSelected.text = "You selected " ..  fieldTable[id].name
		itemSelected.y=700
			local transitionpickerWheelfortime=	transition.to( pickerWheelfortime, { x = display.contentCenterX, time = 400, transition = easing.outExpo } )

		elseif id==7 then 
		-- enables the transition for pickerWheelfordate  for date 
		itemSelected.text = "You selected " ..  fieldTable[id].name
		local transitionpickerWheel= transition.to( pickerWheelfordate, { x = display.contentCenterX, time = 400, transition = easing.outExpo } )
		itemSelected.y=700
		
		elseif id==8 then 
		-- enables the transition for typeofvistpicker
		itemSelected.text = "You selected " ..  fieldTable[id].name
		local transitiontypeofvistpicker= transition.to( typeofvistpicker, { x = display.contentCenterX, time = 400, transition = easing.outExpo } )
		itemSelected.y=700
		
		elseif id==9 then 
		-- enables the transition for reassessmentpicker
		itemSelected.text = "You selected " ..  fieldTable[id].name
		local transitionreassessmentpicker= transition.to( reassessmentpicker, { x = display.contentCenterX, time = 400, transition = easing.outExpo } )
		itemSelected.y=700
		
		
		
		
		else
		 -- response for error debug
		 itemSelected.text = "You selected item " ..  fieldTable[id].name
		 

		end

		
		--Transition out the list, transition in the item selected text and the back button

		-- The table x origin refers to the center of the table in Graphics 2.0, so we translate with half the object's contentWidth
	    local transitionlist= transition.to( list, { x = - list.contentWidth * 0.5, time = 400, transition = easing.outExpo } )
		local transitionitemSelected= transition.to( itemSelected, { x = display.contentCenterX, time = 400, transition = easing.outExpo } )
		local transitionbackButton= transition.to( backButton, { alpha = 1, time = 400, transition = easing.outQuad } )
		-- local transitioncheckboxButton= transition.to(checkboxButton, { x = - list.contentWidth * 0.5, time = 400, transition = easing.outExpo } )
		
		
		
		print( "Tapped and/or Released row: " .. row.index )
	end
end

-- Create a tableView
list = widget.newTableView
{
	top = 138,
	left=159,
	width = 320, 
	height = 448,
	maskFile = "mask-320x448.png",
	onRowRender = onRowRender,
	onRowTouch = onRowTouch,
}


--Insert widgets/images into a group
widgetGroup:insert( list )

widgetGroup:insert( titleBar )
widgetGroup:insert( titleText )
widgetGroup:insert( shadow )
--Handle the back button release event
local function onBackRelease()
	--Transition in the list, transition out the item selected text and the back button
	-- handles all the back transitions
	--The table x origin refers to the center of the table in Graphics 2.0, so we translate with half the object's contentWidth
	transition.to( list, { x = list.contentWidth * 0.9, time = 400, transition = easing.outExpo } )
	transition.to( itemSelected, { x = display.contentWidth + itemSelected.contentWidth * 0.5,y= display.contentCenterY, time = 400, transition = easing.outExpo } )
	transition.to( itemHomeHealthAgency, { x = display.contentWidth + itemSelected.contentWidth * 0.5, time = 400, transition = easing.outExpo } )
	transition.to( itemPatient_Name, { x = display.contentWidth + itemSelected.contentWidth * 0.5, time = 400, transition = easing.outExpo } )
	transition.to( itemTherapist_Name, { x = display.contentWidth + itemSelected.contentWidth * 0.5, time = 400, transition = easing.outExpo } )
	transition.to( itemAuthorized_signatory_name, { x = display.contentWidth + itemSelected.contentWidth * 0.5, time = 400, transition = easing.outExpo } )
	transition.to(sigImage, { x = 1300, time = 400, transition = easing.outExpo } )
-- transition.to( checkboxButton, {   y=140 , x=500,time = 400, transition = easing.outExpo } )
	transition.to( itemauthorized_signatory_relationship, { x = display.contentWidth + itemSelected.contentWidth * 2.5, time = 400, transition = easing.outExpo } )
	transition.to( pickerWheelfortime, { x = display.contentWidth + itemSelected.contentWidth * 2.5, time = 400, transition = easing.outExpo } )
transition.to(pickerWheelfordate, { x = display.contentWidth + itemSelected.contentWidth * 2.5, time = 400, transition = easing.outExpo } )
transition.to(typeofvistpicker, { x = display.contentWidth + itemSelected.contentWidth * 2.5, time = 400, transition = easing.outExpo } )
transition.to(reassessmentpicker, { x = display.contentWidth + itemSelected.contentWidth * 2.5, time = 400, transition = easing.outExpo } )


	transition.to( backButton, { alpha = 0, time = 400, transition = easing.outQuad } )
	
end

--Create the back button
backButton = widget.newButton
{
	width = 298,
	height = 56,
	label = "Back", 
	labelYOffset = - 1,
	onRelease = onBackRelease
}
backButton.alpha = 0
backButton.x = display.contentCenterX
backButton.y = (display.contentHeight - backButton.contentHeight)-30
widgetGroup:insert( backButton )

---[[ 
-- insert rows into list (tableView widget)
for i = 1, 9 do
	list:insertRow{
		height = 72,
	}
end
--]]

-- Create text field

	

	-- Scroll the second column to it's 8'th row
	--pickerWheel:scrollToIndex( 2, 8, 0 )
local function showValuesforTime( event )	
	   require "sqlite3"
   local path = system.pathForFile( "data.db", system.DocumentsDirectory )
 local db = sqlite3.open( path )

	
		local valuestime = pickerWheelfortime:getValues()
		-- print values for time

		---[[
	local ampm=valuestime[1].value
	local hour=valuestime[2].value
	local minute=valuestime[3].value
			print( "\ntime: "..tostring( hour)..":"..tostring(minute)..":" ..tostring(ampm) );
	local timeToDb = [[UPDATE tabletest SET userinput=']].."time: "..hour..":"..minute..":" ..ampm..[[' WHERE id=6;]] 	
	db:exec(timeToDb)
	

print("\n")

---------------------------------------------------------------------------------------------------------------------------
--
-- setting up a print text on screen to see the database output on the app 
--in testing/alpha/beta/final/whatever build delete on screen output 
---------------------------------------------------------------------------------------------------------------------------
for row in db:nrows("SELECT * FROM tabletest WHERE id=6") do
  --local text = row.content
print("\nId "..row.Id.."".." Select op: "..row.name.."\n Input text"..": "..row.userinput)
local text=row.Id.." "..row.name.." "..row.userinput

local t = display.newText(text, 20, 30 * row.Id, null, 16)
  t:setFillColor( 1, 0, 1 )
end
	
		
---------------------------------------------------------------------------------------------------------------------------
--
-- setting up a print text on screen to see the database output on the app 
--in testing/alpha/beta/final/whatever build delete on screen output 
---------------------------------------------------------------------------------------------------------------------------
	
	
	
			--print( "Column", i, "index is:", values[i].index )
	
				local valuesfordates = pickerWheelfordate:getValues()
		-- prints vaules for date 

		---[[
	local month=valuesfordates[1].value
	local day=valuesfordates[2].value
	local year=valuesfordates[3].value
			print(month,day,year)
		local dateToDB=[[UPDATE tabletest SET userinput=']].."date: "..month..":"..day..":"..year..[[' WHERE id=7;]]
		db:exec(dateToDB)
		
	end

	
	
	
	
	
	
	
	

	

	
	local function showValues( event )		
		local reassessmentvist = reassessmentpicker:getValues()
		   require "sqlite3"
   local path = system.pathForFile( "data.db", system.DocumentsDirectory )
 local db = sqlite3.open( path )

		
		local reassessment=reassessmentvist[1].value
			print(  "\nreassessment visit is: ", reassessment)
			--print( "Column", i, "index is:", values[i].index )

		local reassessmentToDB=[[UPDATE tabletest SET userinput=']].."Functional Reassessment: "..reassessment..[[' WHERE id=9;]]
		 db:exec(reassessmentToDB)
		
		local valuesvist = typeofvistpicker:getValues()
		--prints values for type of vist 
		---[[
		local typeofvist=valuesvist[1].value
			print(  "type of vist is: ", typeofvist)
			--print( "Column", i, "index is:", values[i].index )
	
				local typeofvistToDB=[[UPDATE tabletest SET userinput=']].."Types of Visits : "..typeofvist..[[' WHERE id=8;]]
		 db:exec(typeofvistToDB)
		
		
		--prints out other vaules
		print("\nPatient_Name", display.Patient_Name)
		print("Home Health Agency", display.HomeHealthAgency)
		print("Therapist Name", display.Therapist_Name)
		print("authorized signatory name", display.authorized_signatory_name)
		print("authorized signatory relationship", display.authorized_signatory_relationship)
		--]]
	
 -- local dateToDB=[[UPDATE tabletest SET userinput=']].."date: "..month..":"..day..":"..year..[[' WHERE id=7;]]
		-- db:exec(dateToDB)
		print("\n")
  for row in db:nrows("SELECT * FROM tabletest") do
	print("\nId "..row.Id.."".." Select op: "..row.name.."\n Input text"..": "..row.userinput)
	
	-- create table at next available array index
  end

		return true
	end


	local getValuesButton = widget.newButton{
	    id = "getValues",
	    --left = display.contentWidth * 0.5,
	    top = 850,
	    label = "print() values",
	    width = 200, height = backButtonSize,
	    onRelease = showValues;
	}
	getValuesButton.x = display.contentCenterX
	
	local gettimeValuesButton = widget.newButton{
	    id = "getValues",
	    --left = display.contentWidth * 0.5,
	    top = 800,
	    label = "print() time and date",
	    width = 200, height = backButtonSize,
	    onRelease = showValuesforTime;
	}
	gettimeValuesButton.x = display.contentCenterX
	
	
	
	-- all objects must be added to group (e.g. self.view)
	 sceneGroup:insert( bg )
	sceneGroup:insert(pushButton)
	sceneGroup:insert (Therapist_Name)
	 sceneGroup:insert (pickerWheelfordate)
	 sceneGroup:insert (pickerWheelfortime)
-- sceneGroup:insert (checkboxButton)
	 sceneGroup:insert (Patient_Name)
	 sceneGroup:insert( gettimeValuesButton)
	 sceneGroup:insert( getValuesButton )
	sceneGroup:insert(authorized_signatory_name)
	 sceneGroup:insert(authorized_signatory_relationship)
	sceneGroup:insert( typeofvistpicker)
sceneGroup:insert( reassessmentpicker)



end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	transition.to( list, { x = list.contentWidth * 0.9, time = 400, transition = easing.outExpo } )
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- display.remove(checkboxButton)
			-- checkboxButton=nil
						
			display.remove( sigImage)
		display.remove(itemHomeHealthAgency)
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
				
transition.to( list, { x = - list.contentWidth * 0.5, time = 400, transition = easing.outExpo } )
	end
end

function scene:destroy( event )
	   local group = self.view
					
					
			pushButton:removeSelf()

			
			itemAuthorized_signatory_name:removeSelf()
			itemAuthorized_signatory_name=nil
		
			Therapist_Name:removeSelf()
			Therapist_Name=nil
				bg:removeSelf()
				bg=nil
		

			HomeHealthAgency:removeSelf()
			HomeHealthAgency=nil
display.list(remove)
list=nil
storyboard.purgeScene( "scene1" )


	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

 local function onSystemEvent( event )
        if( event.type == "applicationExit" ) then              
            db:close()
        end
	
end
 

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene