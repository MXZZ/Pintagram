import bb.platform 1.0
import bb.cascades 1.0
import bb.system 1.0

TabbedPane {
    
    
    showTabsOnActionBar: true
    id : tabbed
    Menu.definition: MenuDefinition {
        
        // Specify the actions that should be included in the menu
        actions: [
            ActionItem {
                title: "More Info"
                imageSource: "asset:///menu_FAQ.png"
                
                onTriggered: {
                    invoke2.trigger("bb.action.OPEN");
                }
            },
            ActionItem {
                title: "More Apps"
                imageSource: "asset:///Star.png"
                
                onTriggered: {
                    invoke1.trigger("bb.action.OPEN");
                }
            }
        
        ] // end of actions list
    
    } // end of MenuDefinition
    
    Tab { //First tab
        title: "Chats"
        id: mains
        // Localized text with the dynamic translation and locale updates support
        onTriggered: {
            webView.postMessage("profile"); 
        
        }
        
        imageSource: "asset:///bar_chats.png"
        Page {
            
            Container {
                background: Color.White
                ScrollView {
                    id: myscroll
                    scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.None
                    
                    verticalAlignment: VerticalAlignment.Fill
                    horizontalAlignment: HorizontalAlignment.Fill
                    scrollViewProperties.pinchToZoomEnabled: false
                    scrollViewProperties {
                        scrollMode: ScrollMode.None
                    
                    }
                    
                    WebView {
                        url: "local:///assets/web/index.html"
                        id: webView
                        settings.webInspectorEnabled: true
                        
                        settings.userAgent: "BB10"
                        settings.activeTextEnabled: true
                        settings.cookiesEnabled: true
                        settings.javaScriptEnabled: true
                        settings.zoomToFitEnabled: true
                        settings.viewport: {
                            "initial-scale": 1.0,
                            "width": "device-width",
                            "height": "device-height"
                        }
                        onMessageReceived: {
                            if(message.data.toString()=="ready")webView.url="local:///assets/web/index.html";
                            /*if(message==="profile")
                             {
                             webView.reload();
                             webView.url="local:///assets/web/index.html";
                             }*/
                            if(message.data.toString()=="hi"){
                                alert.deleteAllFromInbox();
                                alert.notify();
                            
                            
                            
                            }
                            if(message.data.toString()=="ToContacts")
                            {
                                tabbed.activeTab=contactss;
                            
                            }
                            if(message.data.toString()=="ToSettings")
                            {
                                tabbed.activeTab=settingss;
                            }
                            if(message.data.toString()=="ToMain")
                            {
                                tabbed.activeTab=mains;
                            }
                        
                        }
                        
                        verticalAlignment: VerticalAlignment.Fill
                        horizontalAlignment: HorizontalAlignment.Fill
                        //settings.zoomToFitEnabled: true
                        minHeight: (DisplayInfo.height/9)*8
                        preferredHeight:  (DisplayInfo.height/9)*8
                    
                    
                    }
                }
                
                onCreationCompleted:
                {
                    webView.postMessage("ready");   
                    
                    Application.fullscreen.connect(onFullscreen);
                }
                function onFullscreen() {
                    alert.deleteAllFromInbox();
                }
                clipContentToBounds: false
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
            
            }
            actions: [
                ActionItem {
                    imageSource: "asset:///menu_bar_contact_plus.png"
                    title: "New Contact"
                    onTriggered: {
                        webView.postMessage("ncontact");   
                    }
                },
                ActionItem {
                    imageSource: "asset:///menu_group.png"
                    
                    title: "Open Group"
                    onTriggered: {
                        webView.postMessage("ngroup");   
                    }
                },
                ActionItem {
                    imageSource: "asset:///menu_logout.png"
                    
                    title: "Log Out"
                    onTriggered: {
                        webView.postMessage("logout");   
                    }
                }
            
            ]
        
        }
    
    } //End of first tab
    Tab { //Second tab
        id: contactss
        title: "Contacts"
        imageSource: "asset:///bar_profile.png"
        onTriggered: {
            webView.postMessage("contact");   
        }
    
    } //End of second tab
    Tab { //Second tab
        id: settingss
        title: "Settings"
        imageSource: "asset:///bar_menu_settings.png"
        onTriggered: {
            webView.postMessage("settings"); 
        }
    
    } //End of second tab
    
    attachedObjects: [
        Notification {
            id: alert
            title: "Pintagram"
            body: "You received a new message!"
            //soundUrl: "file:///app/native/assets/notif.wav"
        
        },
        OrientationHandler {
            onOrientationAboutToChange: {
                if (orientation == UIOrientation.Landscape) {
                    // Changing the text and the paddings
                    myscroll.scrollViewProperties.scrollMode=ScrollMode.Vertical;
                } else {
                    myscroll.scrollViewProperties.scrollMode=ScrollMode.None;
                }
            }
        }, // end of OrientationHandler
        Invocation {
            id: invoke1
            query {
                uri: "http://appworld.blackberry.com/webstore/vendor/24197/"
                invokeTargetId: "sys.browser"
                invokeActionId: "bb.action.OPEN"
            } 
        },
        Invocation {
            id: invoke2
            query {
                uri: "https://telegram.org/"
                invokeTargetId: "sys.browser"
                invokeActionId: "bb.action.OPEN"
            } 
        }
    ] // end of attachedObjects

}

