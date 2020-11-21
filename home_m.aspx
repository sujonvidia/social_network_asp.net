<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="home_m.aspx.cs" Inherits="Default3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--<link rel="stylesheet" type="text/css" href="css/home.css?4283671730" id="pagesheet"/>--%>
  
    <style>
        .ajax__tab_header {
            display: block;
        }

        .ajax__tab_body {
            /*background-color: rgba(255, 255, 255, 1)!important;*/
            /*height: 80x !important;*/
            width: 575px !important;
            border-radius: 5px !important;
        }
    </style>
    <meta charset='utf-8' />

    <style>
        textarea {
            border: 2px solid #ccc;
            padding: 10px;
            vertical-align: top;
            width: 25%;
        }

        .animated {
            -webkit-transition: height 0.2s;
            -moz-transition: height 0.2s;
            transition: height 0.2s;
        }
    </style>
 <%--   <script src='http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js'></script>--%>
    <script src='jquery.autosize.js'></script>
    <script>
        $(function () {
            //$('.normal').autosize();
            //$('.animated').autosize
            $('textarea').autosize();
        });
		</script>
    <%--  <script src="js/jquery.js"></script>--%>
    <script src="js/ajaxupload-min.js"></script>
<%--    <link href="css/baseTheme/style.css" rel="stylesheet" media="all" />--%>
   
    <link href="css/classicTheme/style.css" rel="stylesheet" media="all" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <ul class="MenuBar shadow rounded-corners clearfix colelem" id="menuu4965">
        <!-- horizontal box -->

        <asp:Button ID="btnFAKE2" OnClientClick="$('html').css('overflow', 'hidden');" runat="server" Text="Fake Button" Style="display: none;" />
        <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="MPEAddCircle" runat="server" PopupControlID="pnAddCircle" TargetControlID="btnFAKE2"
            DropShadow="true" BackgroundCssClass="modalBackground" CancelControlID="btnCircleCancel" Drag="false">
        </ajaxToolkit:ModalPopupExtender>
        <asp:Panel ID="pnAddCircle" runat="server" CssClass="popup" Style="display: none;">
            Enter Circle Name :
            <asp:TextBox ID="txtNewCircle" runat="server"></asp:TextBox>
            <asp:Button ID="btnCircleCreate" runat="server" Text="Create" OnClick="btnCircleCreate_Click" />
            <asp:Button ID="btnCircleCancel" runat="server" Text="Cancel" />
        </asp:Panel>
        <asp:Menu ID="MenuSub" runat="server" Orientation="Horizontal" BorderStyle="Double" CssClass="Menu" OnMenuItemClick="MenuSub_MenuItemClick" Style="position: relative; width: auto; float: left;">
            <Items>
                <asp:MenuItem Text="All" Value="All"></asp:MenuItem>
                <asp:MenuItem Text="Close Friends" Value="Close Friends"></asp:MenuItem>
                <asp:MenuItem Text="Family" Value="Family"></asp:MenuItem>
                <asp:MenuItem Text="Acquaintances" Value="Acquaintances"></asp:MenuItem>
                <asp:MenuItem Text="More..." Value="More..."></asp:MenuItem>
                <asp:MenuItem Text="+" Value="+"></asp:MenuItem>
            </Items>
        </asp:Menu>
        <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="MPECircleMore" runat="server" PopupControlID="pnCircleMore" TargetControlID="btnFAKE2"
            DropShadow="true" CancelControlID="btnCircleMoreCancel" Drag="false" RepositionMode="None" X="870" Y="70">
        </ajaxToolkit:ModalPopupExtender>
        <asp:Panel ID="pnCircleMore" runat="server" CssClass="popup" Style="display: none;">
            <asp:ListView ID="lstCircleMore" runat="server" DataSourceID="circlemoreDS" OnItemCommand="lstCircleMore_ItemCommand">

                <EditItemTemplate>
                    <span style="">ID:
                       <asp:TextBox ID="IDTextBox" runat="server" Text='<%# Bind("ID") %>' />
                        <br />
                        Name:
                       <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                        <br />
                        UserId:
                       <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                        <br />
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                        <br />
                        <br />
                    </span>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <span>No more circles found.</span>
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <span style="">ID:
                       <asp:TextBox ID="IDTextBox" runat="server" Text='<%# Bind("ID") %>' />
                        <br />
                        Name:
                       <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                        <br />
                        UserId:
                       <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                        <br />
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                        <br />
                        <br />
                    </span>
                </InsertItemTemplate>
                <ItemTemplate>
                    <span style="">

                        <asp:Button ID="ButtonLabel" runat="server" Text='<%# Eval("Name") %>' CommandName="morecircle" />

                        <br />
                    </span>
                </ItemTemplate>
                <LayoutTemplate>
                    <div id="itemPlaceholderContainer" runat="server" style="">
                        <span runat="server" id="itemPlaceholder" />
                    </div>
                    <div style="">
                    </div>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <span style="">ID:
                       <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                        <br />
                        Name:
                       <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                        <br />
                        UserId:
                       <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                        <br />
                        <br />
                    </span>
                </SelectedItemTemplate>
            </asp:ListView>
            <asp:SqlDataSource ID="circlemoreDS" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="circlemoreDS_Selecting" SelectCommand="SELECT * FROM [UserCircles] WHERE ([UserId] = @UserId)">
                <SelectParameters>
                    <asp:Parameter Name="UserId" Type="Object" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Button ID="btnCircleMoreCancel" runat="server" Text="Close" />
        </asp:Panel>


    </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="clearfix colelem" id="u542">
        <!-- group -->
        <div class="museBGSize grpelem">
            <asp:Image ID="ImageProfile" runat="server" CssClass="profilephotoborder" Width="130px" Height="116px" />

        </div>
        <div class="shadow clearfix grpelem" id="post_item">
            <!-- group -->
            <div style="float: right; margin-bottom: 10px">
                <asp:ImageButton ID="ImageButton3" class="icon" runat="server" ImageUrl="~/images/icon/black/tag.png" Width="20" Height="20" Style="display: none;" />
                <asp:ImageButton ID="ImageButton4" class="icon" runat="server" ImageUrl="~/images/icon/black/location.png" Width="20" Style="display: none;" />



                <%--                 <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/icon/black/attach.png" Width="20" OnClientClick=" clk();" />--%>
                <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/images/icon/black/emoticon.png" Width="20" Visible="false" />
            </div>
         <%--   <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Always">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnNewPost" EventName="Click" />
                </Triggers>
                <ContentTemplate>--%>
                    <ajaxToolkit:TabContainer ID="TabContainerPost" runat="server" CssClass="postboxall" ActiveTabIndex="0" Width="132"
                        >
                        <ajaxToolkit:TabPanel HeaderText="Text" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="txtNewPost" class='animated' Style="width: 405px; max-height: 300px; margin-top: 4px;" placeholder="Post Something..." onfocus="this.placeholder=''" onblur="this.placeholder='Post Something...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />

                                <ajaxToolkit:AutoCompleteExtender CompletionListCssClass="AutoExtender" OnClientPopulated="GetFriendImage" OnClientItemSelected="SetTag" ID="AutoCompleteExtender4" runat="server" MinimumPrefixLength="2" ServiceMethod="GetFriendTag" ServicePath="WebService.asmx" TargetControlID="txtNewPost"></ajaxToolkit:AutoCompleteExtender>

                            </ContentTemplate>
                        </ajaxToolkit:TabPanel>
                        <ajaxToolkit:TabPanel HeaderText="Photo" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="txtPhotoPost" class='animated' Style="width: 405px; max-height: 300px; margin-top: 4px;" placeholder="Post Something..." onfocus="this.placeholder=''" onblur="this.placeholder='Post Something...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />
                        <%--        <ajaxToolkit:AsyncFileUpload ThrobberID="imgLoader" CssClass="FileUploadClass" ID="AsyncFileUpload1" runat="server" Style="width: 429px;" OnUploadedComplete="AsyncFileUpload1_UploadedComplete" />
                                <asp:Image ID="imgLoader" CssClass="imgLoader2" runat="server"
                                    ImageUrl="~/images/loading2.gif" />--%>
 <div class="photoupload" runat="server" > </div>
                    <asp:HiddenField ID="uploaded_files_photo" runat="server" />
               <asp:HiddenField ID="uploaded_files_type_photo" runat="server" />
                 <script>
                     var types = "";
                     //$('.photoupload').ajaxupload('option', allowExt, ['jpg', 'gif']);
                     $('.photoupload').ajaxupload({
                         url: 'upload.aspx',
                         autoStart: true,
                         maxFileSize: '2G',
                         maxFiles: 1,

                         //allowExt: [jpg,jpeg,bmp],
                         finish: function (d, obj) {

                             $("#<%=uploaded_files_photo.ClientID %>").val(d);

                             for (i = 0; i < obj.length; i++) {
                                 console.log(obj[i].file.type);
                                 types = obj[i].file.type;

                             }

                             $("#<%=uploaded_files_type_photo.ClientID %>").val(types);


                         }
                     });
                  


    </script>
                            </ContentTemplate>
                        </ajaxToolkit:TabPanel>
                        <ajaxToolkit:TabPanel HeaderText="Video" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="txtVideoPost" class='animated' Style="width: 405px; max-height: 300px; margin-top: 4px;" placeholder="Post Something..." onfocus="this.placeholder=''" onblur="this.placeholder='Post Something...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />
                            <%--    <ajaxToolkit:AsyncFileUpload ThrobberID="imgLoader2" CssClass="FileUploadClass" ID="AsyncFileUpload2" runat="server" Style="width: 429px;" OnUploadedComplete="AsyncFileUpload2_UploadedComplete" />
                                <asp:Image ID="imgLoader2" CssClass="imgLoader2" runat="server"
                                    ImageUrl="~/images/loading2.gif" />--%>

           <div class="videoupload" runat="server" > </div>
               <asp:HiddenField ID="uploaded_files_video" runat="server" />
               <asp:HiddenField ID="uploaded_files_type_video" runat="server" />
                 <script>

                     var types = "";
                     $('.videoupload').ajaxupload({
                         url: 'upload.aspx',
                         autoStart: true,
                         maxFileSize: '2G',
                         maxFiles: 1,


                         finish: function (d, obj) {

                             $("#<%=uploaded_files_video.ClientID %>").val(d);

                             for (i = 0; i < obj.length; i++) {
                                 console.log(obj[i].file.type);
                                 types = obj[i].file.type;

                             }

                             $("#<%=uploaded_files_type_video.ClientID %>").val(types);


                         }

                     });

                     </script>
                            </ContentTemplate>
                        </ajaxToolkit:TabPanel>
                        <ajaxToolkit:TabPanel HeaderText="link" runat="server">
                            <ContentTemplate>
                            <textarea class="one" id="linkpost" name="linkpost"  style="width: 405px; max-height: 300px; margin: 4px 0px 0px; height: 30px;resize: none;" placeholder="Your Link Here..." onfocus="this.placeholder=''" onblur="this.placeholder='Your Link Here...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></textarea>
                           <asp:TextBox ID="txtLinkPost" class='animated3' style="width:405px;max-height: 300px;margin-top: -4px;  resize:none" placeholder="Write Description" onfocus="this.placeholder=''" onblur="this.placeholder='Write Description'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />
                   
        
        <div class="liveurl-loader"></div>
        
        <div class="liveurl">
            <div class="close" title="Entfernen"></div>
            <div class="inner">
                <div class="image"> </div>
                <div class="details">
                    <div class="info">
                        <div class="title"> </div>
                        <div class="description"> </div> 
                        <div class="url"> </div>
                    </div>

                    <div class="thumbnail">
                        <div class="pictures">
                            <div class="controls">
                                <div class="prev button inactive"></div>
                                <div class="next button inactive"></div>
                                <div class="count">
                                    <span class="current">0</span><span> von </span><span class="max">0</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="video"></div>
                </div>

            </div>
        </div>

           <%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js" > </script>--%>
            <script src="jQuery-LiveUrl-master/jquery.liveurl.js"> </script>
            <script>

                var curImages = new Array();

                $('.one').liveUrl({
                    loadStart: function () {
                        $('.liveurl-loader').show();
                    },
                    loadEnd: function () {
                        $('.liveurl-loader').hide();
                    },
                    success: function (data) {
                        var output = $('.liveurl');
                        output.find('.title').text(data.title);
                        output.find('.description').text(data.description);
                        output.find('.url').text(data.url);
                        output.find('.image').empty();

                        output.find('.close').one('click', function () {
                            var liveUrl = $(this).parent();
                            liveUrl.hide('fast');
                            liveUrl.find('.video').html('').hide();
                            liveUrl.find('.image').html('');
                            liveUrl.find('.controls .prev').addClass('inactive');
                            liveUrl.find('.controls .next').addClass('inactive');
                            liveUrl.find('.thumbnail').hide();
                            liveUrl.find('.image').hide();

                            $('.one').trigger('clear');
                            curImages = new Array();
                        });

                        output.show('fast');

                        if (data.video != null) {
                            var ratioW = data.video.width / 350;
                            data.video.width = 350;
                            data.video.height = data.video.height / ratioW;

                            var video =
                            '<object width="' + data.video.width + '" height="' + data.video.height + '">' +
                                '<param name="movie"' +
                                      'value="' + data.video.file + '"></param>' +
                                '<param name="allowScriptAccess" value="always"></param>' +
                                '<embed src="' + data.video.file + '"' +
                                      'type="application/x-shockwave-flash"' +
                                      'allowscriptaccess="always"' +
                                      'width="' + data.video.width + '" height="' + data.video.height + '"></embed>' +
                            '</object>';
                            output.find('.video').html(video).show();


                        }
                    },
                    addImage: function (image) {
                        var output = $('.liveurl');
                        var jqImage = $(image);
                        jqImage.attr('alt', 'Preview');

                        if ((image.width / image.height) > 7
                        || (image.height / image.width) > 4) {
                            // we dont want extra large images...
                            return false;
                        }

                        curImages.push(jqImage.attr('src'));
                        output.find('.image').append(jqImage);


                        if (curImages.length == 1) {
                            // first image...

                            output.find('.thumbnail .current').text('1');
                            output.find('.thumbnail').show();
                            output.find('.image').show();
                            jqImage.addClass('active');

                        }

                        if (curImages.length == 2) {
                            output.find('.controls .next').removeClass('inactive');
                        }

                        output.find('.thumbnail .max').text(curImages.length);
                    }
                });


                $('.liveurl ').on('click', '.controls .button', function () {
                    var self = $(this);
                    var liveUrl = $(this).parents('.liveurl');
                    var content = liveUrl.find('.image');
                    var images = $('img', content);
                    var activeImage = $('img.active', content);

                    if (self.hasClass('next'))
                        var elem = activeImage.next("img");
                    else var elem = activeImage.prev("img");

                    if (elem.length > 0) {
                        activeImage.removeClass('active');
                        elem.addClass('active');
                        liveUrl.find('.thumbnail .current').text(elem.index() + 1);

                        if (elem.index() + 1 == images.length || elem.index() + 1 == 1) {
                            self.addClass('inactive');
                        }
                    }

                    if (self.hasClass('next'))
                        var other = elem.prev("img");
                    else var other = elem.next("img");

                    if (other.length > 0) {
                        if (self.hasClass('next'))
                            self.prev().removeClass('inactive');
                        else self.next().removeClass('inactive');
                    } else {
                        if (self.hasClass('next'))
                            self.prev().addClass('inactive');
                        else self.next().addClass('inactive');
                    }



                });
          </script>
               
                               
                           </ContentTemplate>                    

                       </ajaxToolkit:TabPanel>
                    </ajaxToolkit:TabContainer>



                    <%--         <ajaxToolkit:AutoCompleteExtender CompletionListCssClass="AutoExtender" OnClientPopulated="GetFriendImage" OnClientItemSelected="GetFriendProfile" BehaviorID="acExt" ID="AutoCompleteExtenderPostTag" UseContextKey="true" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" runat="server" MinimumPrefixLength="1" ServiceMethod="GetFriendTag" ServicePath="WebService.asmx" TargetControlID="txtNewPost" > </ajaxToolkit:AutoCompleteExtender> --%>

                    <%--    <asp:TextBox id="demo" class="tags-input" style="
    border: 1px solid #c4c4c4;
" runat="server"/>--%>

                    <div style="margin-top: 10px">
                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/icon/black/privacy.png" Width="20" Height="20" />
                        <asp:DropDownList ID="ddlPrivacy" runat="server">
                            <asp:ListItem>Public</asp:ListItem>
                            <asp:ListItem>Friends</asp:ListItem>
                            <asp:ListItem>Only Me</asp:ListItem>
                        </asp:DropDownList>

                        <%--      <asp:Image ID="Image1" Width="50" Height="50" runat="server" />--%>
                    </div>

                    <div style="float: right; margin-top: -20px; margin-bottom: 10px">

                        <asp:ImageButton ID="btnNewPost" CssClass="icon" runat="server" ImageUrl="~/images/icon/black/post.png" Width="20" OnClick="btnNewPost_Click" />
              <%--  </ContentTemplate>
            </asp:UpdatePanel>
            <ajaxToolkit:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender3"
                TargetControlID="UpdatePanel4" runat="server">
                <Animations>
                <OnUpdating>
                    <Parallel>
                        <ScriptAction Script='onUpdatingpost();' />
                   
                    </Parallel>
                </OnUpdating>
                <OnUpdated>
                    <Parallel>
                        <ScriptAction Script='onUpdatedpost();' />
                  
    
                    </Parallel>
                </OnUpdated>
                </Animations>
            </ajaxToolkit:UpdatePanelAnimationExtender>--%>
            <div id="divImagepost" style="display: none;">
                <div class="spinner" style="margin-left: -50px; margin-top: -49px;">
                    <div class="bounce1"></div>
                    <div class="bounce2"></div>
                    <div class="bounce3"></div>
                </div>
            </div>
        </div>

        <%--                      <asp:FileUpload ID="FileUpload1" runat="server" /></div>--%>
    </div>

    <asp:Button ID="btnFAKE" OnClientClick="$('html').css('overflow', 'hidden');" runat="server" Text="Fake Button" Style="display: none;" />
    <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="MPEShare" runat="server" PopupControlID="PanelShare" TargetControlID="btnFAKE"
        DropShadow="true" BackgroundCssClass="modalBackground" CancelControlID="btnCancel"
        Drag="false">
    </ajaxToolkit:ModalPopupExtender>
    <asp:Panel ID="PanelShare" runat="server" CssClass="popup" Style="display: none;">
        Share:
        <asp:DropDownList ID="ddlShareTo" runat="server">
            <asp:ListItem>On my timeline</asp:ListItem>
            <asp:ListItem>On a friends timeline</asp:ListItem>
            <asp:ListItem>In a group</asp:ListItem>
        </asp:DropDownList><br />

        <asp:TextBox ID="txtFriendsName" runat="server" Visible="true"></asp:TextBox><br />
        <asp:TextBox ID="txtFriendsID" runat="server" CssClass="displaynone"></asp:TextBox>
        <ajaxToolkit:AutoCompleteExtender OnClientItemSelected="GetFriendID" ID="AutoCompleteExtender1" runat="server" MinimumPrefixLength="1" ServiceMethod="GetFriendInfo" ServicePath="WebService2.asmx" TargetControlID="txtFriendsName"></ajaxToolkit:AutoCompleteExtender>
        <asp:TextBox ID="txtShareText" OnClick="this.value=''" runat="server" Text="" TextMode="MultiLine" Rows="2" Width="300" Style="overflow: hidden" onkeyup="setHeight(this)" ToolTip="Say Something about this..."></asp:TextBox><br />

        <asp:Button ID="btnShare" runat="server" Text="Share" OnClick="btnShare_Click" />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" />


    </asp:Panel>
    <div class="clearfix colelem" id="divider_full" style="margin-top: -50px; margin-left: -4px;">
        <!-- group -->
        <div class="clearfix colelem" id="divider_post">
            <!-- group -->
            <div class="clearfix grpelem" id="u599" style="margin-top: -10px;">
                <!-- full post section -->
                <%--<div class="clearfix grpelem" id="u600"><!-- group -->--%>
                <div class="clearfix grpelem" id="pu603">
                    <!-- post divider -->

                    <div>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server"
                            UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:ListView ID="ListView1" runat="server" DataKeyNames="PhotoID,LikeId,UserId,ContentType" DataSourceID="SqlDataSource2" OnItemCreated="ListView1_ItemCreated" OnItemCommand="ListView1_ItemCommand">

                                    <EditItemTemplate>
                                        <span style="">
                                            <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                                        </span>
                                        <div class="colelem post_section_full_grid">
                                            <!-- post section -->

                                            <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />

                                            <div class="position_content">
                                                <div class=" colelem post_profile_photo">
                                                    <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("PostUserId") %>' />

                                                </div>

                                                <div class="post_top_info">

                                                    <asp:HyperLink ID="PostUserLabel" runat="server" Text='<%# Eval("UserFullName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' />
                                                    <br />

                                                    <asp:Label ID="PostDateLabel" runat="server" Text='<%# Eval("Date") %>' />
                                                    <br />
                                                </div>

                                                <div class="colelem post_section">
                                                    <asp:TextBox ID="PostTextBox" runat="server" Text='<%# Bind("Post") %>' Width="268" />

                                                    <br />
                                                </div>
                                                <div style="margin: 10px">
                                                    <asp:Button ID="UpdateButton" runat="server" CommandName="Updatepost" Text="Update" />
                                                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" /><br />
                                                </div>
                                            </div>
                                            <div class="like_dislike_share_section">
                                                <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png"></asp:ImageButton>
                                                <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server">Comment</asp:LinkButton>--%>
                                                <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                                                <asp:ImageButton Visible="false" ID="ImageButtonShare" CssClass="icon" runat="server" CommandName="SharePostId" Width="20" ImageUrl="~/images/icon/black/share3.png"></asp:ImageButton>

                                                <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />

                                                <br />
                                                <asp:Button ID="LinkViewAllComment" runat="server" Visible="true" Text="View all comments" Style="border-width: 1px; width: 270px; background-color: #535461; color: white; border-radius: 5px;" CommandName="allcomment"></asp:Button>
                                            </div>


                                            <%--<div class="_u603 f3s_bot" id="_u603-f3s_bot"></div>--%>
                                        </div>
                                    </EditItemTemplate>
                                    <EmptyDataTemplate>
                                        <span>No posts found.</span>
                                    </EmptyDataTemplate>
                                    <%--<InsertItemTemplate>
                                        <span style="">PostId:
                   <asp:TextBox ID="PostIdTextBox" runat="server" Text='<%# Bind("PostId") %>' />
                                            <br />
                                            Post:
                   <asp:TextBox ID="PostTextBox" runat="server" Text='<%# Bind("Post") %>' />
                                            <br />
                                            PostDate:
                   <asp:TextBox ID="PostDateTextBox" runat="server" Text='<%# Bind("PostDate") %>' />
                                            <br />
                                            UserId:
                   <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                                            <br />
                                            PostContent:
                   <asp:TextBox ID="PostContentTextBox" runat="server" Text='<%# Bind("PostContent") %>' />
                                            <br />
                                            PostContentType:
                   <asp:TextBox ID="PostContentTypeTextBox" runat="server" Text='<%# Bind("PostContentType") %>' />
                                            <br />
                                            PostUser:
                   <asp:TextBox ID="PostUserTextBox" runat="server" Text='<%# Bind("PostUser") %>' />
                                            <br />
                                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                                            <br />
                                            <br />
                                        </span>
                                    </InsertItemTemplate>--%>
                                    <ItemTemplate>
                                        <asp:Panel runat="server" ID="items">
                                            <span style="">
                                                <div class="colelem post_section_full_grid">
                                                    <!-- post section -->
                                                    <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                                                    <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                                                      <asp:Label ID="PhotoIDLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />

                                                    <div class="position_content">
                                                        <div class=" colelem post_profile_photo">
                                                            <asp:Image ID="ImagePostProfile" runat="server"  Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("PostUserId") %>' />

                                                        </div>

                                                        <div class="post_top_info">
                                                            <div class="post_edit_delete" style="margin-right: -5px; margin-top: -3px;">
                                                                <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                                                                <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
    <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you Sure you Want to delete ?"
                                        TargetControlID="DeleteButton">
                                    </ajaxToolkit:ConfirmButtonExtender>
 <%--  <ajaxToolkit:ModalPopupExtender TargetControlID="DeleteButton" BackgroundCssClass="modalBackground" ID="ModalPopupExtender1" runat="server" OkControlID="ok" CancelControlID="cancel" PopupControlID="PanelConfirm">
      
   </ajaxToolkit:ModalPopupExtender>--%>
                                                                 <%-- <ajaxToolkit:AnimationExtender ID="AnimationExtender3" runat="server" TargetControlID="DeleteButton">
                                                                    <Animations>
       <OnClick>

        
            <Parallel AnimationTarget="items" Duration="1" Fps="30">
                <FadeOut AnimationTarget="items" Fps="30" />
                
            </Parallel>
           
           </OnClick>
                                                                    </Animations>
                                                                </ajaxToolkit:AnimationExtender>--%>
                                                            </div>
                                                            <asp:HyperLink ID="PostUserLabel" runat="server" Text='<%# Eval("UserFullName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' />
                                                            <br />

                                                            <asp:Label ID="PostDateLabel" runat="server" Text='<%# Eval("Date") %>' />
                                                            <br />
                                                        </div>

                                                        <div class="colelem post_section">
                                                            <asp:Literal ID="PostLabel" runat="server" Text='<%# AddEmotes( Eval("Post").ToString()) %>' />

                                                            <br />
                                                        </div>

                                                    </div>
                                                    <div class="like_dislike_share_section">
                                                        <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png"></asp:ImageButton>
                                                        <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server">Comment</asp:LinkButton>--%>
                                                        <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                                                        <asp:ImageButton Visible="false" ID="ImageButtonShare" CssClass="icon" runat="server" CommandName="SharePostId" Width="20" ImageUrl="~/images/icon/black/share3.png"></asp:ImageButton>

                                                        <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />

                                                        <br />
                                                        <asp:Button ID="LinkViewAllComment" runat="server" Visible="true" Text="View all comments" Style="border-width: 1px; width: 270px; background-color: #535461; color: white; border-radius: 5px;" CommandName="allcomment"></asp:Button>
                                                        <ajaxToolkit:AnimationExtender ID="AnimationExtender1" runat="server" TargetControlID="LinkViewAllComment">
                                                            <Animations>
       <OnClick>

        
            <Parallel AnimationTarget="PanelPostComment" Duration="3" Fps="25">
                <FadeOut AnimationTarget="PanelPostComment" minimumOpacity=".1" Fps="30" />
                <FadeIn AnimationTarget="PanelPostComment" minimumOpacity=".1" Fps="30" />  
            </Parallel>
           
           </OnClick>
                                                            </Animations>
                                                        </ajaxToolkit:AnimationExtender>
                                                    </div>


                                                    <%--<div class="_u603 f3s_bot" id="_u603-f3s_bot"></div>--%>
                                                </div>
                                                <asp:Panel ID="PanelPostComment" runat="server">
                                                    <asp:ListView ID="ListViewPostComment" runat="server" DataKeyNames="PhotoID,LikeId,CommentUserId" DataSourceID="MediaDS" InsertItemPosition="LastItem" OnItemInserting="lvMediaComment_ItemInserting" OnItemCreated="ListViewPostComment_ItemCreated" OnItemCommand="ListViewPostComment_ItemCommand">

                                                        <EditItemTemplate>
                                                            <span style="">CommentId:
                    <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                                                                <br />
                                                                Comment:
                    <asp:TextBox ID="CommentTextBox" class='animated' TextMode="MultiLine" Style="width: 200px" runat="server" Text='<%# Bind("Comment") %>' />
                                                                <br />
                                                                CommentUser:
                    <asp:TextBox ID="CommentUserTextBox" runat="server" Text='<%# Bind("CommentUser") %>' />
                                                                <br />
                                                                CommentDate:
                    <asp:TextBox ID="CommentDateTextBox" runat="server" Text='<%# Bind("CommentDate") %>' />
                                                                <br />
                                                                PostId:
                    <asp:TextBox ID="PostIdTextBox" runat="server" Text='<%# Bind("PhotoID") %>' />
                                                                <br />
                                                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                                                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                                                                <br />
                                                                <br />
                                                            </span>
                                                        </EditItemTemplate>
                                                        <EmptyDataTemplate>
                                                            <span>No Comment found.</span>
                                                        </EmptyDataTemplate>
                                                        <InsertItemTemplate>
                                                            <asp:Panel DefaultButton="InsertButton" runat="server">
                                                                <span style="">
                                                                    <div class="colelem comment_new_full" style="margin-bottom: 15px;">
                                                                        <div class=" grpelem comment_new_profile_photo">
                                                                            <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />


                                                                        </div>
                                                                        <div class="comment_new_section">
                                                                            <asp:TextBox ID="CommentTextBox" class='animated' Style="width: 190px; height: 25px; margin-left: -5px;" placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" runat="server" TextMode="MultiLine" Text='<%# Bind("Comment") %>' />
                                                                            <asp:Button ID="InsertButton" runat="server" Style="margin-left: 205px; height: 30px; width: 70px; background-color: #26284f; color: white; margin-bottom: 10px;" CommandName="Insert" Text="Comment" />
                                                                        </div>


                                                                        <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                                                                    </div>
                                                                </span>
                                                            </asp:Panel>
                                                        </InsertItemTemplate>
                                                        <ItemTemplate>

                                                            <span style="">
                                                                <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                                                                <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />


                                                                <div class="colelem comment_post_full">
                                                                    <div class="position_content">
                                                                        <div class=" grpelem comment_post_profile_photo">
                                                                            <asp:ImageButton ID="ImageProfile2" runat="server" Style="height: 41px; width: 45px; margin-top: -10px;" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

                                                                        </div>

                                                                        <div class="comment_post_info">
                                                                            <asp:HyperLink ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' NavigateUrl='<%# Eval("CommentUserName","~/index_m.aspx?un={0}") %>' /><br />
                                                                            <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                                                                        </div>
                                                                        <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                                                                        <div class="colelem comment_post_section" style="margin-top: -10px;">
                                                                            <asp:Literal ID="PostLabel" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                                                                            <br />
                                                                        </div>
                                                                    </div>
                                                                    <%--<div style="margin-top:40px;">--%>
                                                                    <div class="comment_post_like_section" style="margin-top: 17px;">
                                                                        <%--   <asp:Button ID="LinkButtonLike" runat="server" CommandName="LikeButtonComment" Text="Like" ></asp:Button>--%>
                                                                        <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png"></asp:ImageButton>


                                                                        <%--  <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>

                                                                        <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                                                                        <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                                                                    </div>
                                                                    <%--</div>--%>
                                                                    <hr style="    margin: 0px;"/>

                                                                </div>

                                                                <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
                                                            </span>
                                                        </ItemTemplate>
                                                        <LayoutTemplate>
                                                            <div id="itemPlaceholderContainer" runat="server" style="">
                                                                <span runat="server" id="itemPlaceholder" />
                                                            </div>
                                                            <div style="">
                                                            </div>
                                                        </LayoutTemplate>
                                                        <SelectedItemTemplate>
                                                            <span style="">CommentId:
                    <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' />
                                                                <br />
                                                                Comment:
                    <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />
                                                                <br />
                                                                CommentUser:
                    <asp:Label ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' />
                                                                <br />
                                                                CommentDate:
                    <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                                                                <br />
                                                                PostId:
                    <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' />
                                                                <br />
                                                                <br />
                                                            </span>
                                                        </SelectedItemTemplate>
                                                    </asp:ListView>
                                                </asp:Panel>

                                            </span>
                                        </asp:Panel>
                                    </ItemTemplate>
                                    <LayoutTemplate>
                                        <div id="itemPlaceholderContainer" runat="server" style="">
                                            <span runat="server" id="itemPlaceholder" />
                                        </div>
                                        <div style="">
                                        </div>
                                    </LayoutTemplate>
                                    <%--<SelectedItemTemplate>
                                        <span style="">PostId:
                   <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' />
                                            <br />
                                            Post:
                   <asp:Label ID="PostLabel" runat="server" Text='<%# Eval("Post") %>' />
                                            <br />
                                            PostDate:
                   <asp:Label ID="PostDateLabel" runat="server" Text='<%# Eval("PostDate") %>' />
                                            <br />
                                            UserId:
                   <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                                            <br />
                                            PostContent:
                   <asp:Label ID="PostContentLabel" runat="server" Text='<%# Eval("PostContent") %>' />
                                            <br />
                                            PostContentType:
                   <asp:Label ID="PostContentTypeLabel" runat="server" Text='<%# Eval("PostContentType") %>' />
                                            <br />
                                            PostUser:
                   <asp:Label ID="PostUserLabel" runat="server" Text='<%# Eval("PostUser") %>' />
                                            <br />
                                            <br />
                                        </span>
                                    </SelectedItemTemplate>--%>
                                </asp:ListView>
                                <asp:SqlDataSource ID="PostDataSource1" runat="server" OnSelecting="PostDataSource1_Selecting" ConnectionString="<%$ 

ConnectionStrings:SecurityConnectionString %>"
                                    SelectCommand="SELECT top(@TopVal) * FROM [UserPosts] WHERE (([UserId] IN (SELECT [friend_id] FROM [FriendsList] WHERE my_id  = @my_id ) ) AND ([UserPosts].[Privacy] <> 'Only Me') OR [UserId]= @me) AND ([PostContentType] IS NULL) ORDER BY [PostDate] DESC">
                                    <SelectParameters>
                                        <asp:Parameter Name="my_id" />
                                        <asp:Parameter Name="me" />
                                        <asp:Parameter Name="TopVal" DefaultValue="4" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                  <asp:SqlDataSource ID="SqlDataSource2" runat="server" OnSelecting="PostDataSource1_Selecting" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" 
                                      SelectCommand="(SELECT top(@TopVal) * FROM PhotoStore WHERE (( [UserId]= @me OR [UserId] IN (SELECT [friend_id] FROM [FriendsList] WHERE my_id  = @my_id)) AND ([Privacy] <> 'Only Me') and ([ContentType] ='post' and [PostType]='profile')))  order by [Date] desc">
         <SelectParameters>
                                        <asp:Parameter Name="my_id" />
                                        <asp:Parameter Name="me" />
                                        <asp:Parameter Name="TopVal" DefaultValue="4" Type="Int32" />
                                    </SelectParameters>
    </asp:SqlDataSource>
                                 <asp:SqlDataSource ID="MediaDS" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [PhotoComments] WHERE ([PhotoID] = @PhotoID) ORDER BY [CommentDate]" OnSelecting="MediaDS_Selecting">
                 <SelectParameters>
                     <asp:Parameter Name="PhotoID" Type="Object" />
                     
                 </SelectParameters>
             </asp:SqlDataSource>
                                <asp:SqlDataSource ID="PostCommentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [UserComments] WHERE ([PostId] = @PostId) ORDER BY [CommentDate]" OnSelecting="PostCommentDataSource_Selecting">
                                    <SelectParameters>
                                        <asp:Parameter Name="PostId" Type="Object" />
                                    </SelectParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="LikeDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [UserLikes]"></asp:SqlDataSource>



                                </div>
       </div>
     
                            </ContentTemplate>
                            <Triggers>

                                <asp:AsyncPostBackTrigger ControlID="LoadMore" EventName="Click"></asp:AsyncPostBackTrigger>
                                <asp:AsyncPostBackTrigger ControlID="btnNewPost" EventName="Click"></asp:AsyncPostBackTrigger>

                            </Triggers>
                        </asp:UpdatePanel>
                    </div>


                    <%--<asp:SqlDataSource ID="CommentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="CommentDataSource_Selecting" SelectCommand="SELECT [Comment], [CommentDate], [CommentUser], [PostId] FROM [UserComments] WHERE ([PostId] = @PostId)">
              <SelectParameters>
                  <asp:Parameter Name="PostId" Type="Object" />
              </SelectParameters>
          </asp:SqlDataSource>--%>



                    <div class="clearfix grpelem" id="pu602">
                        <!-- Media divider -->
                        <div>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server"
                                UpdateMode="Conditional">
                                <ContentTemplate>

                                    <div class="shadow colelem" id="u602" style="margin-left: 290px;">
                                        <!-- group -->

                                        <asp:ListView ID="ListView2" runat="server" DataKeyNames="PhotoID,LikeId,UserId,ContentType" DataSourceID="MediaDataSource" OnItemCreated="ListView2_ItemCreated" OnItemCommand="ListView2_ItemCommand" OnItemDataBound="ListView2_ItemDataBound">

                                            <EditItemTemplate>
                                                <span style="">
                                                    <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                                                </span>
                                                <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                                                <asp:Label ID="PostContentTypeLabel" runat="server" Text='<%# Eval("ContentType") %>' Visible="false" />

                                                <div class="colelem post_section_full_grid" style="background-color: white;">
                                                    <!-- post section -->


                                                    <div class="position_content">
                                                        <div class=" colelem post_profile_photo">
                                                            <asp:Image ID="ImagePostProfile" runat="server"  Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("PostUserId") %>' />

                                                        </div>

                                                        <div class="post_top_info">
                                                            <div class="post_edit_delete" style="margin-right: -5px; margin-top: -3px;">
                                                                <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                                                                <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
        <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you Sure you Want to delete ?"
                                        TargetControlID="DeleteButton">
                                    </ajaxToolkit:ConfirmButtonExtender>
  <%-- <ajaxToolkit:ModalPopupExtender TargetControlID="DeleteButton" BackgroundCssClass="modalBackground" ID="ModalPopupExtender1" runat="server" OkControlID="ok" CancelControlID="cancel" PopupControlID="PanelConfirm">
      
   </ajaxToolkit:ModalPopupExtender>--%>
                                                                 </div>
                                                            <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("UserFullName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' />
                                                            <br />

                                                            <asp:Label ID="PostDateLabel" runat="server" Text='<%# Eval("Date") %>' />
                                                            <br />
                                                        </div>


                                                        <div class="post_media_section">

                                                            <%--                <video id="embed1"  controls="controls" src='<%# "ThumbnailHandlerPostMedia.ashx?postid=" + Eval("PostId") %>' width="268" height="240"></video>--%>
                                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' />
                                                        </div>
                                                        <div class="colelem post_section">
                                                            <asp:TextBox ID="PostTextBox" runat="server" Text='<%# Bind("Description") %>' Width="268" BorderColor="Black" BorderStyle="Solid" BorderWidth="1" />
                                                            <br />
                                                        </div>
                                                        <div style="margin: 10px;">
                                                            <asp:Button ID="UpdateButton" runat="server" CommandName="Updatepost" Text="Update" />
                                                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                                                        </div>
                                                    </div>
                                                    <div class="colelem like_dislike_share_section" style="background-color: #DEF0F4">
                                                        <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png"></asp:ImageButton>
                                                        <%--<asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server" >Comment</asp:LinkButton>--%>
                                                        <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                                                        <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                                                        <asp:ImageButton Visible="false" ID="ImageButtonShare" CssClass="icon" runat="server" CommandName="SharePostId" Width="20" ImageUrl="~/images/icon/black/share3.png"></asp:ImageButton>

                                                        <br />
                                                        <asp:Button ID="LinkViewAllComment" runat="server" Visible="true" Text="View all comments" Style="border-width: 1px; width: 270px; background-color: #535461; color: white; border-radius: 5px;" CommandName="allcomment"></asp:Button>
                                                    </div>


                                                    <%--<div class="_u603 f3s_bot" id="_u603-f3s_bot"></div>--%>
                                                </div>
                                            </EditItemTemplate>
                                            <EmptyDataTemplate>
                                                <span>No data was returned.</span>
                                            </EmptyDataTemplate>
                                            <%--<InsertItemTemplate>
                                                <span style="">PostId:
                         <asp:TextBox ID="PostIdTextBox" runat="server" Text='<%# Bind("PostId") %>' />
                                                    <br />
                                                    Post:
                         <asp:TextBox ID="PostTextBox" runat="server" Text='<%# Bind("Post") %>' />
                                                    <br />
                                                    PostDate:
                         <asp:TextBox ID="PostDateTextBox" runat="server" Text='<%# Bind("PostDate") %>' />
                                                    <br />
                                                    UserId:
                         <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                                                    <br />
                                                    PostContent:
                         <asp:TextBox ID="PostContentTextBox" runat="server" Text='<%# Bind("PostContent") %>' />
                                                    <br />
                                                    PostContentType:
                         <asp:TextBox ID="PostContentTypeTextBox" runat="server" Text='<%# Bind("PostContentType") %>' />
                                                    <br />
                                                    PostUser:
                         <asp:TextBox ID="PostUserTextBox" runat="server" Text='<%# Bind("PostUser") %>' />
                                                    <br />
                                                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                                                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                                                    <br />
                                                    <br />
                                                </span>
                                            </InsertItemTemplate>--%>
                                            <ItemTemplate>
                                                <asp:Panel runat="server" ID="items">
                                                    <span style="">
                                                        <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                                                        <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                                                        <asp:Label ID="PostContentTypeLabel" runat="server" Text='<%# Eval("ContentType") %>' Visible="false" />
                                                        <asp:Label ID="PhotoIDLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />

                                                        <div class="colelem post_section_full_grid" style="background-color: white;">
                                                            <!-- post section -->


                                                            <div class="position_content">
                                                                <div class=" colelem post_profile_photo">
                                                                    <asp:Image ID="ImagePostProfile" runat="server"  Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("PostUserId") %>' />

                                                                </div>

                                                                <div class="post_top_info">
                                                                    <div class="post_edit_delete" style="margin-right: -5px; margin-top: -3px;">
                                                                        <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                                                                        <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
     <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you Sure you Want to delete ?"
                                        TargetControlID="DeleteButton">
                                    </ajaxToolkit:ConfirmButtonExtender>
   <%--<ajaxToolkit:ModalPopupExtender TargetControlID="DeleteButton" BackgroundCssClass="modalBackground" ID="ModalPopupExtender1" runat="server" OkControlID="ok" CancelControlID="cancel" PopupControlID="PanelConfirm">
      
   </ajaxToolkit:ModalPopupExtender>--%>
                                                                         <%--<ajaxToolkit:AnimationExtender ID="AnimationExtender3" runat="server" TargetControlID="DeleteButton">
                                                                            <Animations>
       <OnClick>

        
            <Parallel AnimationTarget="items" Duration="1" Fps="30">
                <FadeOut AnimationTarget="items" Fps="30" />
                
            </Parallel>
           
           </OnClick>
                                                                            </Animations>
                                                                        </ajaxToolkit:AnimationExtender>--%>
                                                                    </div>
                                                                    <asp:HyperLink ID="PostUserLabel" runat="server" Text='<%# Eval("UserFullName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' />
                                                                    <br />

                                                                    <asp:Label ID="PostDateLabel" runat="server" Text='<%# Eval("Date") %>' />
                                                                    <br />
                                                                </div>
                                  


                                                                <div class="post_media_section">
                                                                    <asp:Panel runat="server" Visible="false" ID="pnlVideo" Style="height: 235px;">
                                                                        <video runat="server" id="videoplayer" style="height: 220px; width: 268px;" controls="controls" src='<%# Eval("ImageUrl") %>'></video>
                                                                    </asp:Panel>
                                                                      <a class='inline' href="#inline_content" runat="server" id="photo_popup">   
                                                                    <asp:ImageButton ID="imgbtn" Width="200" Height="200"  runat="server" ImageUrl='<%# Eval("ImageUrl") %>' Visible="false" Style="margin-left: 35px;" />
                                                                          </a>
<%--                                                                  
      <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="MPEPopImage" CancelControlID="btnClose" DropShadow="true" BackgroundCssClass="modalBackgroundImage" Drag="false" runat="server" TargetControlID="imgbtn" PopupControlID="Panel1"></ajaxToolkit:ModalPopupExtender>--%>
                                                                      <div style='display:none'>
			<div id='inline_content' style='padding:10px; background:#fff;' runat="server">
                            
                                                                    <asp:Panel ID="Panel1" runat="server" Style="margin-top: 50px; z-index: 10000; height: 500px; opacity: 1; box-shadow: rgb(0, 0, 0) 5px 5px 5px; background-color: white;">
                                                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Always">
                                                                            <ContentTemplate>
                                                                                 <div style="float: left">
                                                                            <asp:Image Width="700" Height="500" ID="ImageButton22" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' />

                                                                        </div>
                                                                        <div style="float: right; margin: 20px;">
                                                                            <asp:Button ID="btnClose" runat="server" Text="X" Style="margin-left: -735px; display: block; clear: both; width: 30px; height: 30px; border-radius: 300px; margin-top: -34px; border: 6px solid rgb(242, 243, 244); background: rgb(204, 222, 232); color: rgb(10, 22, 45); font-weight: bold; margin-top: -38px;" />
                                                                            <asp:ImageButton ID="Image2" runat="server" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' Style="vertical-align: top" />
                                                                            <%--                                            <asp:HyperLink ID="FullNameLabel" runat="server" Text='<%# Eval("FirstName") %>' NavigateUrl='<%# Eval("UserId","~/profile-list_search.aspx?userid={0}") %>' />--%>

                                                                            <asp:HyperLink ID="HyperLink2" runat="server" Text='<%# Eval("UserFullName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' />

                                                                            <asp:Label ID="DateCreatedLabel" runat="server" Style="display: block; margin-left: 56px; margin-top: -16px;" Text='<%# Eval("Date") %>' /><br />
                                                                            <asp:Label ID="Label1" runat="server" Style="margin-bottom: 20px; display: block; margin-top: 5px;" Text='<%# Eval("Description") %>' /><br />

                                                                            <asp:ListView ID="ListView3" runat="server" DataKeyNames="PostId,LikeId,CommentUserId" DataSourceID="MediaCommentDataSource" InsertItemPosition="LastItem" OnItemInserting="ListView3_ItemInserting" OnItemCreated="ListViewMediaComment_ItemCreated" OnItemCommand="ListViewMediaComment_ItemCommand">

                                                                                <EditItemTemplate>
                                                                                    <span style="">CommentId:
                         <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                                                                                        <br />
                                                                                        Comment:
                         <asp:TextBox ID="CommentTextBox" class='animated' TextMode="MultiLine" Style="width: 200px" runat="server" Text='<%# Bind("Comment") %>' />
                                                                                        <br />
                                                                                        CommentUser:
                         <asp:TextBox ID="CommentUserTextBox" runat="server" Text='<%# Bind("CommentUser") %>' />
                                                                                        <br />
                                                                                        CommentDate:
                         <asp:TextBox ID="CommentDateTextBox" runat="server" Text='<%# Bind("CommentDate") %>' />
                                                                                        <br />
                                                                                        PostId:
                         <asp:TextBox ID="PostIdTextBox" runat="server" Text='<%# Bind("PostId") %>' />
                                                                                        <br />
                                                                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                                                                                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                                                                                        <br />
                                                                                        <br />
                                                                                    </span>
                                                                                </EditItemTemplate>
                                                                                <EmptyDataTemplate>
                                                                                    <span>No data was returned.</span>
                                                                                </EmptyDataTemplate>
                                                                                <InsertItemTemplate>
                                                                                    <asp:Panel DefaultButton="InsertButton" runat="server">
                                                                                        <span style="">
                                                                                            <%--<div class="_u608 f3s_top" id="_u608-f3s_top"></div>--%>
                                                                                            <div class="colelem comment_new_full" style="margin-bottom: 15px;">
                                                                                                <div class=" grpelem comment_new_profile_photo">
                                                                                                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />


                                                                                                </div>
                                                                                                <div class="comment_new_section" style="">
                                                                                                    <asp:TextBox ID="CommentTextBox" class='animated' Style="width: 190px; height: 25px; margin-left: -5px;" placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" runat="server" TextMode="MultiLine" Text='<%# Bind("Comment") %>' />
                                                                                                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Comment" Style="margin-left: 210px; height: 30px; width: 70px; background-color: #26284f; color: white; margin-bottom: 5px;" />
                                                                                                </div>


                                                                                                <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                                                                                            </div>
                                                                                            <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
                                                                                        </span>
                                                                                    </asp:Panel>
                                                                                </InsertItemTemplate>
                                                                                <ItemTemplate>

                                                                                    <span style="">
                                                                                        <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                                                                                        <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' Visible="false" />


                                                                                        <div class="colelem comment_post_full" style="margin-bottom: 25px; margin-top: 20px;">
                                                                                            <div class="position_content" style="margin-top: -15px;">
                                                                                                <div class=" grpelem comment_post_profile_photo" style="margin-top: -11px;">
                                                                                                    <asp:ImageButton ID="ImageProfile2" runat="server" Style="display: block;"
                                                                                                        Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

                                                                                                </div>

                                                                                                <div class="comment_post_info">
                                                                                                    <%--                <asp:Label ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' /><br />--%>
                                                                                                    <asp:HyperLink ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' NavigateUrl='<%# Eval("CommentUserName","~/index_m.aspx?un={0}") %>' />

                                                                                                    <asp:Label ID="CommentDateLabel" runat="server" Style="display: block;"
                                                                                                        Text='<%# Eval("CommentDate") %>' />
                                                                                                </div>
                                                                                                <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                                                                                                <div class="colelem comment_post_section" style="margin-top: -10px; padding: 5px;">
                                                                                                    <asp:Literal ID="PostLabel" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                                                                                                    <br />
                                                                                                </div>
                                                                                            </div>
                                                                                            <%--<div style="margin-top:40px;">--%>
                                                                                            <div class="comment_post_like_section" style="margin-top: 17px;">
                                                                                                <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButtonComment" CommandArgument='<%# Eval("CommentUserId") %>' Width="20" ImageUrl="~/images/icon/black/thumbs_like.png"></asp:ImageButton>
                                                                                                <%--  <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>

                                                                                                <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                                                                                                <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                                                                                            </div>
                                                                                            <%--</div>--%>
                                                                                            <hr style="
    margin: 0px;
"/>

                                                                                        </div>

                                                                                        <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
                                                                                    </span>
                                                                                </ItemTemplate>
                                                                                <LayoutTemplate>
                                                                                    <div id="itemPlaceholderContainer" runat="server" style="">
                                                                                        <span runat="server" id="itemPlaceholder" />
                                                                                    </div>
                                                                                    <div style="">
                                                                                    </div>
                                                                                </LayoutTemplate>
                                                                                <SelectedItemTemplate>
                                                                                    <span style="">CommentId:
                         <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' />
                                                                                        <br />
                                                                                        Comment:
                         <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />
                                                                                        <br />
                                                                                        CommentUser:
                         <asp:Label ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' />
                                                                                        <br />
                                                                                        CommentDate:
                         <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                                                                                        <br />
                                                                                        PostId:
                         <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' />
                                                                                        <br />
                                                                                        <br />
                                                                                    </span>
                                                                                </SelectedItemTemplate>
                                                                            </asp:ListView>

                                                                        </div>
                         
                                                                            </ContentTemplate>
                                                                        </asp:UpdatePanel>
                                                                                      
                                                                    </asp:Panel>
                         
                </div></div>
                                                                </div>


                                                                <div class="colelem post_section">
                                                                 
                                                                       <asp:Literal ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' /><br />
                   <asp:Literal ID="Literal1" runat="server" Text='<%# AddEmotes( Eval("Description").ToString()) %>' /><br />
                       <asp:HyperLink  CssClass="one" ID="HyperLink1" NavigateUrl='<%# Eval("Link") %>' runat="server"><%# Eval("Link") %></asp:HyperLink>
                                                                    <br />
                                                                </div>

                                                            </div>
                                                            <div class="colelem like_dislike_share_section" style="background-color: #DEF0F4">
                                                                <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png"></asp:ImageButton>
                                                                <%--<asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server" >Comment</asp:LinkButton>--%>
                                                                <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                                                                <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                                                                <asp:ImageButton Visible="false" ID="ImageButtonShare" CssClass="icon" runat="server" CommandName="SharePostId" Width="20" ImageUrl="~/images/icon/black/share3.png"></asp:ImageButton>

                                                                <br />
                                                                <asp:Button ID="LinkViewAllComment" runat="server" Visible="true" Text="View all comments" Style="border-width: 1px; width: 270px; background-color: #535461; color: white; border-radius: 5px;" CommandName="allcomment"></asp:Button>
                                                                <ajaxToolkit:AnimationExtender ID="AnimationExtender1" runat="server" TargetControlID="LinkViewAllComment">
                                                                    <Animations>
       <OnClick>

        
            <Parallel AnimationTarget="PanelMediaComment" Duration="3" Fps="25">
                <FadeOut AnimationTarget="PanelMediaComment" minimumOpacity=".1" Fps="30" />
                <FadeIn AnimationTarget="PanelMediaComment" minimumOpacity=".1" Fps="30" />  
            </Parallel>
           
           </OnClick>
                                                                    </Animations>
                                                                </ajaxToolkit:AnimationExtender>
                                                            </div>


                                                            <%--<div class="_u603 f3s_bot" id="_u603-f3s_bot"></div>--%>
                                                        </div>
                                                        <asp:Panel runat="server" ID="PanelMediaComment">
                                                            <asp:ListView ID="ListViewMediaComment" runat="server" DataKeyNames="PhotoID,LikeId,CommentUserId" DataSourceID="MediaDS" InsertItemPosition="LastItem" OnItemInserting="lvMediaComment_ItemInserting" OnItemCreated="ListViewMediaComment_ItemCreated" OnItemCommand="ListViewMediaComment_ItemCommand">

                                                                <EditItemTemplate>
                                                                    <span style="">CommentId:
                         <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                                                                        <br />
                                                                        Comment:
                         <asp:TextBox ID="CommentTextBox" class='animated' TextMode="MultiLine" Style="width: 200px" runat="server" Text='<%# Bind("Comment") %>' />
                                                                        <br />
                                                                        CommentUser:
                         <asp:TextBox ID="CommentUserTextBox" runat="server" Text='<%# Bind("CommentUser") %>' />
                                                                        <br />
                                                                        CommentDate:
                         <asp:TextBox ID="CommentDateTextBox" runat="server" Text='<%# Bind("CommentDate") %>' />
                                                                        <br />
                                                                        PostId:
                         <asp:TextBox ID="PostIdTextBox" runat="server" Text='<%# Bind("PhotoID") %>' />
                                                                        <br />
                                                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                                                                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                                                                        <br />
                                                                        <br />
                                                                    </span>
                                                                </EditItemTemplate>
                                                                <EmptyDataTemplate>
                                                                    <span>No data was returned.</span>
                                                                </EmptyDataTemplate>
                                                                <InsertItemTemplate>
                                                                    <asp:Panel DefaultButton="InsertButton" runat="server">
                                                                        <span style="">
                                                                            <div class="colelem comment_new_full" style="margin-bottom: 15px;">
                                                                                <div class=" grpelem comment_new_profile_photo">
                                                                                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />


                                                                                </div>
                                                                                <div class="comment_new_section">
                                                                                    <asp:TextBox ID="CommentTextBox" class='animated' Style="width: 190px; height: 25px; margin-left: -5px;" placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" runat="server" TextMode="MultiLine" Text='<%# Bind("Comment") %>' />
                                                                                    <asp:Button ID="InsertButton" runat="server" Style="margin-left: 205px; height: 30px; width: 70px; background-color: #26284f; color: white; margin-bottom: 10px;" CommandName="Insert" Text="Comment" />
                                                                                </div>


                                                                                <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                                                                            </div>
                                                                        </span>
                                                                    </asp:Panel>
                                                                </InsertItemTemplate>
                                                                <ItemTemplate>

                                                                    <span style="">
                                                                        <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                                                                        <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />


                                                                        <div class="colelem comment_post_full">
                                                                            <div class="position_content">
                                                                                <div class=" grpelem comment_post_profile_photo">
                                                                                    <asp:ImageButton ID="ImageProfile2" runat="server" Style="height: 41px; width: 45px; margin-top: -10px;" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

                                                                                </div>

                                                                                <div class="comment_post_info">
                                                                                    <asp:HyperLink ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' NavigateUrl='<%# Eval("CommentUserName","~/index_m.aspx?un={0}") %>' /><br />
                                                                                    <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                                                                                </div>
                                                                                <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                                                                                <div class="colelem comment_post_section" style="margin-top: -10px;">
                                                                                    <asp:Literal ID="PostLabel" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                                                                                    <br />
                                                                                </div>
                                                                            </div>
                                                                            <%--<div style="margin-top:40px;">--%>
                                                                            <div class="comment_post_like_section" style="margin-top: 17px;">
                                                                                <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png"></asp:ImageButton>
                                                                                <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>

                                                                                <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                                                                                <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                                                                            </div>
                                                                            <%--</div>--%>
                                                                            <hr style="    margin: 0px;"/>

                                                                        </div>
                                                                    </span>
                                                                </ItemTemplate>
                                                                <LayoutTemplate>
                                                                    <div id="itemPlaceholderContainer" runat="server" style="">
                                                                        <span runat="server" id="itemPlaceholder" />
                                                                    </div>
                                                                    <div style="">
                                                                    </div>
                                                                </LayoutTemplate>
                                                                <SelectedItemTemplate>
                                                                    <span style="">CommentId:
                         <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' />
                                                                        <br />
                                                                        Comment:
                         <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />
                                                                        <br />
                                                                        CommentUser:
                         <asp:Label ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' />
                                                                        <br />
                                                                        CommentDate:
                         <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                                                                        <br />
                                                                        PostId:
                         <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' />
                                                                        <br />
                                                                        <br />
                                                                    </span>
                                                                </SelectedItemTemplate>
                                                            </asp:ListView>
                                                        </asp:Panel>

                                                        


                                                    </span>
                                                </asp:Panel>
                                            </ItemTemplate>
                                            <LayoutTemplate>
                                                <div id="itemPlaceholderContainer" runat="server" style="">
                                                    <span runat="server" id="itemPlaceholder" />
                                                </div>
                                                <div style="">
                                                </div>
                                            </LayoutTemplate>
                                            <SelectedItemTemplate>
                                                <span style="">PostId:
                         <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' />
                                                    <br />
                                                    Post:
                         <asp:Label ID="PostLabel" runat="server" Text='<%# Eval("Post") %>' />
                                                    <br />
                                                    PostDate:
                         <asp:Label ID="PostDateLabel" runat="server" Text='<%# Eval("PostDate") %>' />
                                                    <br />
                                                    UserId:
                         <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                                                    <br />
                                                    PostContent:
                         <asp:Label ID="PostContentLabel" runat="server" Text='<%# Eval("PostContent") %>' />
                                                    <br />
                                                    PostContentType:
                         <asp:Label ID="PostContentTypeLabel" runat="server" Text='<%# Eval("PostContentType") %>' />
                                                    <br />
                                                    PostUser:
                         <asp:Label ID="PostUserLabel" runat="server" Text='<%# Eval("PostUser") %>' />
                                                    <br />
                                                    <br />
                                                </span>
                                            </SelectedItemTemplate>
                                        </asp:ListView>
                                        <asp:SqlDataSource ID="MediaDataSource" runat="server" OnSelecting="MediaDataSource_Selecting" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" 
                                            SelectCommand=" (SELECT top(@TopVal) * FROM PhotoStore WHERE (( [UserId]= @me OR [UserId] IN (SELECT [friend_id] FROM [FriendsList] WHERE my_id  = @my_id)) AND ([Privacy] <> 'Only Me') and ([ContentType] <>'post' and [PostType]='profile')) ) UNION ALL  (SELECT top(@TopVal) * FROM VideoStore WHERE (( [UserId]= @me OR [UserId] IN (SELECT [friend_id] FROM [FriendsList] WHERE my_id  = @my_id)) AND ([Privacy] <> 'Only Me') and ([ContentType] <>'post' and [PostType]='profile'))) ORDER BY [Date] DESC">
                                            <SelectParameters>
                                                <asp:Parameter Name="my_id" />
                                                <asp:Parameter Name="me" />
                                                <asp:Parameter Name="TopVal" DefaultValue="4" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="MediaCommentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [UserComments] WHERE ([PostId] = @PostId) ORDER BY [CommentDate]" OnSelecting="MediaCommentDataSource_Selecting">
                                                            <SelectParameters>
                                                                <asp:Parameter Name="PostId" Type="Object" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                    </div>



                                </ContentTemplate>
                                <Triggers>

                                    <asp:AsyncPostBackTrigger ControlID="LoadMore" EventName="Click"></asp:AsyncPostBackTrigger>
                                    <asp:AsyncPostBackTrigger ControlID="btnNewPost" EventName="Click"></asp:AsyncPostBackTrigger>

                                </Triggers>
                            </asp:UpdatePanel>
                        </div>

                         <asp:Panel ID="PanelConfirm" runat="server" CssClass="popup"  Style="display:none;padding:20px; border-radius:5px;z-index:1000000000000 !important">
                                    <asp:Label runat="server" Text="Are you sure you want to delete this post?"></asp:Label>
       <asp:Button runat="server" Text="OK" ID="ok" OnClientClick="return false;" />
       <asp:Button runat="server" Text="Cancel" ID="cancel" /> 
                               </asp:Panel>


                    </div>
                    <div class="clearfix colelem">
                        <asp:Button ID="LoadMore" runat="server" Height="28px" Text="Load More..." Width="300" Style="display: none" OnClick="LoadMore_Click" />
                        <div id="divImage" style="display: none">
                            <div class="spinner" style="margin-left: 270px;">
                                <div class="bounce1"></div>
                                <div class="bounce2"></div>
                                <div class="bounce3"></div>
                            </div>

                        </div>
                    </div>
                    <ajaxToolkit:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender1"
                        TargetControlID="UpdatePanel2" runat="server">
                        <Animations>
            <OnUpdating>
               <Parallel duration="0">
                    <ScriptAction Script="onUpdating();" />
                                    
                </Parallel>
            </OnUpdating>
            <OnUpdated>
                <Parallel duration="0">
                    <ScriptAction Script="onUpdated();" />
                    <FadeOut Duration="1.5" Fps="24" AnimationTarget="ContentPlaceHolder1_ListView2_items_0" />
     <FadeIn Duration="1.5" Fps="24"  AnimationTarget="ContentPlaceHolder1_ListView2_items_0" />
                  
                </Parallel>
            </OnUpdated>
                        </Animations>
                    </ajaxToolkit:UpdatePanelAnimationExtender>
                    <ajaxToolkit:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender2"
                        TargetControlID="UpdatePanel1" runat="server">
                        <Animations>
            <OnUpdating>
               <Parallel duration="0">
                    <ScriptAction Script="onUpdating();" />
                                    
                </Parallel>
            </OnUpdating>
            <OnUpdated>
                <Parallel duration="0">
                    <ScriptAction Script="onUpdated();" />
                    <FadeOut Duration="1.5" Fps="24" AnimationTarget="ContentPlaceHolder1_ListView1_items_0" />
     <FadeIn Duration="1.5" Fps="24"  AnimationTarget="ContentPlaceHolder1_ListView1_items_0" />
                  
                </Parallel>
            </OnUpdated>
                        </Animations>
                    </ajaxToolkit:UpdatePanelAnimationExtender>
                </div>

            </div>


            

        </div>
        <div class="pinned-colelem" id="u1213">
            <!-- simple frame -->
        </div>
    </div>
        <div class="clearfix grpelem" id="divider_right" style="margin-top: 40px; margin-left: 785px;">
                <!-- column -->
                <div id="listgrid_bar" style="width: 135px; margin-left: 15px; margin-top: 40px; position: relative; float: left;">
                    <asp:ImageButton ID="ImageButtonGrid" runat="server" CssClass="" ImageUrl="~/images/icon/black/horizontal20.png" OnClick="ImageButtonGrid_Click" Height="40px" Width="40px" />
                    <asp:ImageButton ID="ImageButtonList" runat="server" CssClass="" ImageUrl="~/images/icon/black/six15.png" OnClick="ImageButtonList_Click" Height="40px" Width="40px" />


                    <asp:ImageButton ID="btnChangeBackground" OnClientClick="$('html').css('overflow', 'hidden');" runat="server" Height="40" Width="40" Text="Change Background" ImageUrl="~/images/icon/black/photo146.png" />

                    <asp:Panel ID="pnChangeBackground" runat="server" CssClass="popup2" Style="display: none;">
                        Choose Your Background:<br />

                        <ajaxToolkit:AjaxFileUpload ID="AjaxFileUpload1" runat="server" OnUploadComplete="AjaxFileUpload1_UploadComplete"
                            OnClientUploadComplete="OnClientUploadComplete" MaximumNumberOfFiles="1" AllowedFileTypes="jpg,jpeg,tiff,png,gif" />

                        <asp:Button ID="btnbckcancel" runat="server" Text="Cancel" />

                    </asp:Panel>
                    <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="ModalPopupExtender2" runat="server" PopupControlID="pnChangeBackground"
                        TargetControlID="btnChangeBackground"
                        DropShadow="true" BackgroundCssClass="modalBackground" CancelControlID="btnbckcancel"
                        Drag="false">
                    </ajaxToolkit:ModalPopupExtender>


                </div>
                <div class="clearfix colelem" id="side_menu">
                    <!-- group -->
                    <div class="clearfix grpelem" id="side_menu_bar" style="margin-top: 80px;">
                        <!-- column -->
                        <asp:Button ID="btnPost" runat="server" Text="Post" CssClass="sidecatmenu" />
                        <asp:Button ID="btnVideo" runat="server" Text="Video" CssClass="sidecatmenu" OnClick="btnVideo_Click" />
                        <asp:Button ID="btnPhoto" runat="server" Text="Photo" CssClass="sidecatmenu" OnClick="btnPhoto_Click" />
                        <asp:Button ID="btnFriend" runat="server" Text="Friend" CssClass="sidecatmenu" OnClick="btnFriend_Click" />
                        <asp:Button ID="btnAbout" runat="server" Text="About" CssClass="sidecatmenu" OnClick="btnAbout_Click" />
                    </div>

                </div>
            </div>
</asp:Content>

