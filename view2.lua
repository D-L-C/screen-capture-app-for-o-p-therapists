-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )

local scene = composer.newScene()
local widget = require("widget")
local fingerPaint = require("fingerPaint")
-- local storyboard= require("storyboard") 

local function onFirstView( event )
composer.gotoScene( "view1" )
composer.tabBar:setSelected( 1, true )
end

-- set variables for various screen positions
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local screenTop = display.screenOriginY
local screenLeft = display.screenOriginX
local screenBottom = display.screenOriginY+display.actualContentHeight
local screenRight = display.screenOriginX+display.actualContentWidth
local screenWidth = screenRight - screenLeft
local screenHeight = screenBottom - screenTop

	local canvas = fingerPaint.newCanvas(screenWidth * .75, screenHeight * .7)

	

-- create a button to enable/disable drawing & a function to perform the change
local function enableDisable(event)
	if canvas.isActive then
		canvas.isActive = false
		event.target:setLabel("enable painting")
	else
		canvas.isActive = true
		event.target:setLabel("disable painting")
	end
end

local enableDisableButton = widget.newButton{
	label = "disable painting",
	width = 0,
	height = 0,
	fontSize = 20,
	onRelease = enableDisable
}



 local screenCap

local function captureOnEvent()
--time screen capture   
    -- Capture the screen
	-- creates sub-folder then places file within the folder
	
	local lfs= require "lfs" 
	

	-- raw path for app Docutments dir
	local docs_path =system.pathForFile ("", system.DocumentsDirectory) 
	for file in lfs.dir(docs_path) do
   --file is the current file or directory name
   print( "Found file: " .. file )
end
	-- change current workigng directory 
	local success = lfs.chdir(docs_path) -- returns true on success
	local new_folder_path
	
	local dname="/screen_cap_images4"
	
	if success then
	lfs.mkdir("screen_cap_images4")
	new_folder_path= lfs.currentdir() ..  "/screen_cap_images4"
	end

	
	
	-- another folder, made for when I was testing the code 
	-- local success2 = lfs.chdir(docs_path) -- returns true on success
	-- local second_new_folder_path
	
	-- local dname2="new_screen_cap_images3"
	
	-- if success2 then
	-- lfs.mkdir(dname2)
	-- second_new_folder_path= lfs.currentdir() .. "/" .. dname2
	-- end
	

     screenCap = display.captureScreen(false)
	local baseDir = system.DocumentsDirectory
	local group =display.newGroup()
	group:insert(screenCap)
		screenCap:toBack()
		
		
	onFirstView()
		
    local capture =display.save( group, {filename= dname.."/".."screenscapper.png",baseDir, isFullResolution=true } )
	local refile=system.pathForFile(dname.."/".."screencapper.png",baseDir)
	local file =io.open (refile,"w")
	file:write(dname.."/".."screencapper.png")
	io.close(file)

	-- local results, reason =os.rename(system.pathForFile(dname.."/".."screencapper.png",baseDir),
				-- system.pathForFile(dname.."/".."renamescreencap",baseDir))
				
			-- if results then
			-- print("file renamed")
			-- else
			-- print("file not renamed", reason)
			-- end
	
	
	
	
	-- local path = system.pathForfile(new_folder_path, system.DocumentsDierectory,0,0)
	-- local fileHandle=io.path(path, "w")
	
		-- fileHandle:write(capture)
	function doesFileExist( fname, path )

    local results = false

    local filePath = system.pathForFile( fname, path )

    -- filePath will be nil if file doesn't exist and the path is ResourceDirectory
    -- --
     if filePath then
        filePath = io.open( filePath, "r" )
    end

     if  filePath then
         print( "File found -> " .. fname )
        -- -- Clean up our file handles
        filePath:close()
        results = true
     else
         print( "File does not exist -> " .. fname )
     end

     print()

     return results
 end

-- Checking for file in Documents directory
 local results = doesFileExist(dname.."/".. "screenscapper.png", baseDir)
    function copyFile( srcName, srcPath, dstName, dstPath, overwrite )

    local results = false

    local srcPath = doesFileExist( srcName, srcPath )

    if ( srcPath == false ) then
        return nil  -- nil = source file not found
    end

    --check to see if destination file already exists
    if not ( overwrite ) then
        if ( fileLib.doesFileExist( dstName, dstPath ) ) then
            return 1  -- 1 = file already exists (don't overwrite)
        end
    end

	--copy the source file to the destination file
    local rfilePath = system.pathForFile( srcName, srcPath )
    local wfilePath = system.pathForFile( dstName, dstPath )

    local rfh = io.open( rfilePath, "rb" )
    local wfh = io.open( wfilePath, "wb" )

    if not ( wfh ) then
        print( "writeFileName open error!" )
        return false
    else
        --read the file from 'system.ResourceDirectory' and write to the destination directory
        local data = rfh:read( "*a" )
        if not ( data ) then
            print( "read error!" )
            return false
        else
            if not ( wfh:write( data ) ) then
                print( "write error!" )
                return false
            end
        end
    end

    results = 2  -- 2 = file copied successfully!

    --clean up file handles
    rfh:close()
    wfh:close()

    return results
end

	--copyFile( "screenscapper.png.txt", nil, "screenscapper.png", system.DocumentsDirectory, true )

	
    -- Scale the screen capture, now on the screen, to half its size
    -- screenCap:scale( 0.5, 0.5 )
    -- screenCap.x = display.contentCenterX
    -- screenCap.y = display.contentCenterY

    -- Alert the user to look in the library (device) or on the desktop (Simulator) for the screen capture
    local alert = native.showAlert( "Success", "Screen Capture Saved to Library", { "OK" } )
	

	display.remove( screenCap )

if screenCap ~= nil then
    screenCap:removeSelf()
end
	
	
	
local function uploadListener( event )
   if ( event.isError ) then
      print( "Network Error." )

      -- This is likely a time out or server being down. In other words,
      -- It was unable to communicate with the web server. Now if the
      -- connection to the web server worked, but the request is bad, this
      -- will be false and you need to look at event.status and event.response
      -- to see why the web server failed to do what you want.
   else
      if ( event.phase == "began" ) then
         print( "Upload started" )
      elseif ( event.phase == "progress" ) then
         print( "Uploading... bytes transferred ", event.bytesTransferred )
      elseif ( event.phase == "ended" ) then
         print( "Upload ended..." )
         print( "Status:", event.status )
         print( "Response:", event.response )              
		 print ( "RESPONSE: " .. event.response )

      end
   end
end


-- Sepcify the URL of the PHP script to upload to. Do this on your own server.
-- Also define the method as "PUT".
local crypto = require "crypto"


local method = "GET"
local mime = require("mime")
	local sqlite3 = require ("sqlite3")
local http = require("socket.http")
local json = require("json")

local username= "Guest"
local password="Pass"
 -- username=mime.b64(username)
 -- password=mime.b64(password)

--local method = "PUT"
-- local user="guest",
    -- local password="pass",
      -- local  secure="true"
local commands_json  = {
            ["password"] = mime.b64(password),
            ["username"] = mime.b64(username) ,
         
        }
	-- Set some reasonable parameters for the upload process:
	local headers = {}
	headers["username"]= username
	headers["password"]= password
	 headers["Content-Type"] = 'json'
    headers["Accept-Language"] = "en-US"
	headers["Status"]="ok"
	headers["Statuscode"]='100'
	headers["basic-credentials"]='base64-user-pass'
	headers["base64-user-pass"]  ='<base64 encoded user-pass>'
	local URL = "http://cloud.inpresence.us/remote.php/webdav/";
	
	-- local URL = "http://"..username..":"..password.."@cloud.inpresence.us/remote.php/webdav/";
  local params = {}
 params.headers = headers
    params.progress = "upload"
	print( URL)
local contentType = "image/png"  

 local filename=dname.."/".."screenscapper.png"
    print( "File found -> " .. filename )
 headers.filename = filename
 

 	-- local URL = "http://"..mime.unb64(username)..":"..mime.unb64(password).."@cloud.inpresence.us/remote.php/webdav/music/documents";


params.body = {
        filename ,
		"object.json",
        baseDirectory = system.DocumentsDirectory,      
		binary,
		"application/json"
        }
		
		
		print( "durr",18 )
network.request( URL , method, uploadListener, headers)
	print( "test url request",18 )





	--local webView = native.newWebView( display.contentCenterX, display.contentCenterY, 320, 480 )
--webView:request( "http://cloud.inpresence.us/remote.php/webdav" )


	--network.upload( url , method, uploadListener, params, filename, baseDir, contentType )

--system.openURL("http://Guest:Pass@cloud.inpresence.us/remote.php/webdav")
--'://'.urlencode($uid).':'.urlencode($password).'@'.$webdavauth_url_path;
end


local function quickLookListener( event )
    print( event.name ) -- "popup"
    print( event.type ) -- "quickLook"
    print( event.action ) -- "done"
    print( event.file ) -- FileTable of last item previewed prior to dismissing. eg { filename = "myFile.txt", baseDir = system.ResourceDirectory }
end
 
 
 local function mailshare(event)
 

 
		local  options = 
{
androidAppPackageName="com.owncloud.android",
   
	 attachment =
     { 

         {baseDir = system.DocumentsDirectory, filename ="/screen_cap_images4".."/".. "screenscapper.png", type="image/png" },
     },
	 supportedAndroidStores={"google"},
    listener = quickLookListener,
}
 
native.showPopup( "mail", options);
end

local uploadButton = widget.newButton{
	label = "upload",
	width = 0,
	height = 0,
	fontSize = 20,
	onRelease = mailshare
}




local enablescreenCapButton = widget.newButton{
	label = "screen capture",
	width = 0,
	height = 0,
	fontSize = 20,
	
	onRelease=captureOnEvent
	
	}

	
		
local erase = widget.newButton{
	label = "erase",
	width = 0,
	height = 0,
	fontSize = 20,
	onRelease = canvas.erase
}
	
function scene:create( event )
	local sceneGroup = self.view
	
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

	
	
	enableDisableButton.anchorX, enableDisableButton.anchorY = 1, 1
	enableDisableButton.x, enableDisableButton.y = screenRight - 20, screenBottom - 120
	
	enablescreenCapButton.anchorX, enablescreenCapButton.anchorY = 1, 1
	enablescreenCapButton.x, enablescreenCapButton.y = screenRight - 20, screenBottom - 100
	
	uploadButton.anchorX, uploadButton.anchorY = 0, 1
		uploadButton.x, uploadButton.y = screenLeft + 60, screenBottom - 100
		
	canvas.anchorX, canvas.anchorY = .5, 0
	canvas.x, canvas.y = centerX, screenTop+20
	
	erase.anchorX, erase.anchorY = 0, 1
	erase.x, erase.y = screenLeft + 60, screenBottom - 120
		
	
	
	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( bg )
sceneGroup:insert(uploadButton)
	
	sceneGroup:insert(erase)
sceneGroup:insert(enableDisableButton)
sceneGroup:insert(enablescreenCapButton)
	sceneGroup:insert(canvas)
	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	
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
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		
	elseif phase == "did" then
		-- Called when the scene is now off screen
		
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	bg:removeSelf()
	bg=nil
	canvas:removeSelf()
	canvas=nil
	uploadButton:removeSelf()
	uploadButton=nil
	erase:removeSelf()
	erase=nil
		enableDisableButton:removeSelf()
		enableDisableButton=nil
		enablescreenCapButton:removeSelf()
		enablescreenCapButton=nil
	display.remove( screenCap )

if screenCap ~= nil then
    screenCap:removeSelf()
end
	
	composer.purgeScene( "scene2" )
		
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end


enablescreenCapButton.anchorX, enablescreenCapButton.anchorY = 1, 1
	enablescreenCapButton.x, enablescreenCapButton.y = screenRight - 180, screenBottom - 40	
	
	enableDisableButton.anchorX, enableDisableButton.anchorY = 1, 1
	enableDisableButton.x, enableDisableButton.y = screenRight - 20, screenBottom - 40	

	erase.anchorX, erase.anchorY = 0, 1
	erase.x, erase.y = screenLeft + 10, screenBottom - 80
		
	
	
---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
