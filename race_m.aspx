<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="race_m.aspx.cs" Inherits="Default3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <meta charset='utf-8'/>
		
		<style>
      #ContentPlaceHolder_top_menu_MenuMain a.popout{
          margin-left:20px!important;
      }


			textarea {
				border:2px solid #ccc;
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
	<%--	<script src='http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js'></script>--%>
		<script src='jquery.autosize.js'></script>
		<script>
		    $(function () {
		        //$('.normal').autosize();
		        //$('.animated').autosize();
		        $('textarea').autosize();
		    });
		</script>
    <style>
         .ajax__tab_header {
margin-top: -16px;
display:block;}
.ajax__tab_body{
width:430px;
}
.sidecatmenu{
    height:35px;
}

#ContentPlaceHolder_top_menu_MenuMain a{
    background-color:#525461 !important;
    margin-left:0px !important;
}

    </style>
 
   <%-- <script src="js/jquery.js"></script>--%>
    <script src="js/ajaxupload-min.js"></script>
<%--    <link href="css/baseTheme/style.css" rel="stylesheet" media="all" />--%>
   
    <link href="css/classicTheme/style.css" rel="stylesheet" media="all" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_top_menu" Runat="Server" >
    <asp:Menu ID="MenuSub" runat="server" Orientation="Horizontal" BorderStyle="Double" CssClass="Menu" BackColor="#32374B" OnMenuItemClick="MenuSub_MenuItemClick" style="position: relative; width: auto; float: left;height: 25px;" >
            <Items>
                <asp:MenuItem Text="All Ranks" Value="All Ranks"></asp:MenuItem>
                <asp:MenuItem Text="Novice" Value="Novice"></asp:MenuItem>
                <asp:MenuItem Text="Advanced" Value="Advanced"></asp:MenuItem>
                <asp:MenuItem Text="Elite" Value="Elite"></asp:MenuItem>
                <asp:MenuItem Text="Super" Value="Super"></asp:MenuItem>
                <asp:MenuItem Text="+" Value="+"></asp:MenuItem>
            </Items>
        </asp:Menu>
    <asp:Menu ID="MenuMain" style="float: left; background-color: rgb(82, 84, 97);width: 70px; height:20px;-moz-border-radius: 0px 0px 5px 5px ;-webkit-border-radius: 0px 0px 5px 5px ;-khtml-border-radius: 0px 0px 5px 5px ;border-radius: 0px 0px 5px 5px ;" runat="server"  ForeColor="White" OnMenuItemClick="MenuMain_MenuItemClick">
                <Items>
                    <asp:MenuItem Text="All" Value="All">
                                            <asp:MenuItem Text="Art" Value="Art">
                        <asp:MenuItem Text="Paint" Value="Paint"></asp:MenuItem>
                        <asp:MenuItem Text="Graphics" Value="Graphics"></asp:MenuItem>
                        <asp:MenuItem Text="Sketch" Value="Sketch"></asp:MenuItem>
                    </asp:MenuItem>
                    <asp:MenuItem Text="Business" Value="Business">
                        <asp:MenuItem Text="Idea" Value="Idea"></asp:MenuItem>
                        
                        <asp:MenuItem Text="Vacancy" Value="Vacancy"></asp:MenuItem>
                        <asp:MenuItem Text="Job offer" Value="Job offer"></asp:MenuItem>
                        <asp:MenuItem Text="Job application" Value="Job application"></asp:MenuItem>
                    </asp:MenuItem>
                    <asp:MenuItem Text="Education" Value="Education">
                        <asp:MenuItem Text="Commerce" Value="Commerce"></asp:MenuItem>
                        <asp:MenuItem Text="Science" Value="Science"></asp:MenuItem>
                        <asp:MenuItem Text="Engineering" Value="Engineering"></asp:MenuItem>
                        <asp:MenuItem Text="Arts" Value="Arts"></asp:MenuItem>
                        <asp:MenuItem Text="Humanities" Value="Humanities"></asp:MenuItem>
                        <asp:MenuItem Text="School" Value="School"></asp:MenuItem>
                        <asp:MenuItem Text="College" Value="College"></asp:MenuItem>
                    </asp:MenuItem>
                    <asp:MenuItem Text="Literature" Value="Literature">
                        <asp:MenuItem Text="Poem" Value="Poem"></asp:MenuItem>
                        <asp:MenuItem Text="Stories" Value="Stories"></asp:MenuItem>
                        <asp:MenuItem Text="Novel" Value="Novel"></asp:MenuItem>
                    </asp:MenuItem>
                    <asp:MenuItem Text="Music" Value="Music">
                        <asp:MenuItem Text="Alternative" Value="Alternative"></asp:MenuItem>
                        <asp:MenuItem Text="Blues" Value="Blues"></asp:MenuItem>
                        <asp:MenuItem Text="Classical" Value="Classical"></asp:MenuItem>
                        <asp:MenuItem Text="Country" Value="Country"></asp:MenuItem>
                        <asp:MenuItem Text="Dance" Value="Dance"></asp:MenuItem>
                        <asp:MenuItem Text="Electronic" Value="Electronic"></asp:MenuItem>
                        <asp:MenuItem Text="Folk" Value="Folk"></asp:MenuItem>
                        <asp:MenuItem Text="Hip-Hop/Rap" Value="Hip-Hop/Rap"></asp:MenuItem>
                        <asp:MenuItem Text="Jazz" Value="Jazz"></asp:MenuItem>
                        <asp:MenuItem Text="New Age" Value="New Age"></asp:MenuItem>
                        <asp:MenuItem Text="Opera" Value="Opera"></asp:MenuItem>
                        <asp:MenuItem Text="Pop" Value="Pop"></asp:MenuItem>
                        <asp:MenuItem Text="R&amp;B/Soul" Value="R&amp;B/Soul"></asp:MenuItem>
                        <asp:MenuItem Text="Reggae" Value="Reggae"></asp:MenuItem>
                        <asp:MenuItem Text="Rock" Value="Rock"></asp:MenuItem>
                        <asp:MenuItem Text="Singer/Songwritter" Value="Singer/Songwritter"></asp:MenuItem>
                        <asp:MenuItem Text="World Music/Beats" Value="World Music/Beats"></asp:MenuItem>
                    </asp:MenuItem>
                    <asp:MenuItem Text="Recreational" Value="Recreational">
                        <asp:MenuItem Text="Comic" Value="Comic"></asp:MenuItem>
                        <asp:MenuItem Text="Jokes" Value="Jokes"></asp:MenuItem>
                        <asp:MenuItem Text="Trivia" Value="Trivia"></asp:MenuItem>
                        <asp:MenuItem Text="Review" Value="Review"></asp:MenuItem>
                    </asp:MenuItem>
                    <asp:MenuItem Text="Video" Value="Video">
                        <asp:MenuItem Text="Flim" Value="Flim"></asp:MenuItem>
                        <asp:MenuItem Text="Short Flim" Value="Short Flim"></asp:MenuItem>
                        <asp:MenuItem Text="Documentary" Value="Documentary"></asp:MenuItem>
                        <asp:MenuItem Text="Trip" Value="Trip"></asp:MenuItem>
                    </asp:MenuItem>
                    </asp:MenuItem>

                </Items>
            </asp:Menu>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_left_menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="clearfix colelem" id="u1325" style="margin-left: 183px;"><!-- column -->
     <div class="clearfix colelem post_new_up_full" style="margin-top: 35px;"><!-- group -->
      <div class="museBGSize grpelem">
           <asp:Image ID="ImageProfile" runat="server" Width="130px" Height="116px" CssClass="profilephotoborder" />
      </div>
  <div class="shadow clearfix grpelem" id="post_item"><!-- group -->
       <div>
          <asp:TextBox ID="txtPostTitle" runat="server" placeholder="Title Name" onfocus="this.placeholder=''" onblur="this.placeholder='Title Name'" style=" margin-left: 270px; "></asp:TextBox>
          </div>
         <div style="float:right;margin-bottom:10px">
             <asp:ImageButton ID="ImageButton3" class="icon" runat="server" ImageUrl="~/images/icon/black/tag.png" Width="20" Height="20" style="display: none;"/>
                 <asp:ImageButton ID="ImageButton4" class="icon" runat="server" ImageUrl="~/images/icon/black/location.png" Width="20" style="display: none;"/>
           
               
                 
<%--                 <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/icon/black/attach.png" Width="20" OnClientClick=" clk();" />--%>
                 <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/images/icon/black/emoticon.png" Width="20" Visible="false" />
             </div>
    <%-- <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
                 <Triggers>
                     <asp:AsyncPostBackTrigger ControlID="btnNewPost" EventName="Click" />
                   
                    
                 </Triggers>
                 <ContentTemplate>--%>
                   <ajaxToolkit:TabContainer ID="TabContainerPost" runat="server" CssClass="postboxall" ActiveTabIndex="0" width="132"

            >
                       <ajaxToolkit:TabPanel HeaderText="Text" runat="server">
                           <ContentTemplate>
                                               <asp:TextBox ID="txtNewPost" class='animated' style="width:405px;max-height: 300px;margin-top: 4px; height:80px;" placeholder="Post Something..." onfocus="this.placeholder=''" onblur="this.placeholder='Post Something...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />

                                <ajaxToolkit:AutoCompleteExtender CompletionListCssClass="AutoExtender" OnClientPopulated="GetFriendImage" OnClientItemSelected="SetTag" ID="AutoCompleteExtender4" runat="server" MinimumPrefixLength="2" ServiceMethod="GetFriendTag" ServicePath="WebService.asmx" TargetControlID="txtNewPost" > </ajaxToolkit:AutoCompleteExtender> 

                                </ContentTemplate>
                       </ajaxToolkit:TabPanel>
                        <ajaxToolkit:TabPanel HeaderText="Photo" runat="server">
                           <ContentTemplate>
                                               <asp:TextBox ID="txtPhotoPost" class='animated' style="width:405px;max-height: 300px;margin-top: 4px;" placeholder="Post Something..." onfocus="this.placeholder=''" onblur="this.placeholder='Post Something...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />
           <%--    <ajaxToolkit:AsyncFileUpload ThrobberID="imgLoader" CssClass="FileUploadClass" ID="AsyncFileUpload1" runat="server" style="width: 429px;" OnUploadedComplete="AsyncFileUpload1_UploadedComplete" />
<asp:Image ID="imgLoader" CssClass="imgLoader2" runat="server"
        ImageUrl = "~/images/loading2.gif" />--%>

  <div class="photoupload" runat="server" > </div>
                    <asp:HiddenField ID="uploaded_files_photo" runat="server" />
               <asp:HiddenField ID="uploaded_files_type_photo" runat="server" />
                 <script>
                     var types_photo = "";
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
                                 types_photo = obj[i].file.type;

                             }

                             $("#<%=uploaded_files_type_photo.ClientID %>").val(types_photo);


                         }
                     });



    </script>

                                </ContentTemplate>
                       </ajaxToolkit:TabPanel>
                        <ajaxToolkit:TabPanel HeaderText="Video" runat="server">
                           <ContentTemplate>
                                               <asp:TextBox ID="txtVideoPost" class='animated' style="width:405px;max-height: 300px;margin-top: 4px;" placeholder="Post Something..." onfocus="this.placeholder=''" onblur="this.placeholder='Post Something...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />
             <%--  <ajaxToolkit:AsyncFileUpload ThrobberID="imgLoader2" CssClass="FileUploadClass" ID="AsyncFileUpload2" runat="server" style="width: 429px;" OnUploadedComplete="AsyncFileUpload2_UploadedComplete" />
<asp:Image ID="imgLoader2" CssClass="imgLoader2" runat="server"
        ImageUrl = "~/images/loading2.gif" />--%>

 <div class="videoupload" runat="server" > </div>
               <asp:HiddenField ID="uploaded_files_video" runat="server" />
               <asp:HiddenField ID="uploaded_files_type_video" runat="server" />
                 <script>

                     var types_video = "";
                     $('.videoupload').ajaxupload({
                         url: 'upload.aspx',
                         autoStart: true,
                         maxFileSize: '2G',
                         maxFiles: 1,


                         finish: function (d, obj) {

                             $("#<%=uploaded_files_video.ClientID %>").val(d);

                             for (i = 0; i < obj.length; i++) {
                                 console.log(obj[i].file.type);
                                 types_video = obj[i].file.type;

                             }

                             $("#<%=uploaded_files_type_video.ClientID %>").val(types_video);


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
           
              <div style="float:left; display:inline;margin-top:10px">
             <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True" OnTextChanged="ddlCategory_TextChanged">
                <asp:ListItem>Art</asp:ListItem>
                <asp:ListItem>Business</asp:ListItem>
                <asp:ListItem>Education</asp:ListItem>
                <asp:ListItem>Literature</asp:ListItem>
                <asp:ListItem>Music</asp:ListItem>
                <asp:ListItem>Recreational</asp:ListItem>
                <asp:ListItem>Video</asp:ListItem>
            </asp:DropDownList>
            <asp:DropDownList ID="ddlSubCategory" runat="server" AutoPostBack="True">
                <asp:ListItem>Graphics</asp:ListItem>
                <asp:ListItem>Paint</asp:ListItem>
                <asp:ListItem>Sketch</asp:ListItem>
            </asp:DropDownList>
        </div>
                  
                <div style="float: right;  ">

                    <asp:ImageButton ID="btnNewPost" CssClass="icon" runat="server" ImageUrl="~/images/icon/black/post.png" Width="20" OnClick="btnNewPost_Click" />
                 
                   
               <%--        </ContentTemplate>
</asp:UpdatePanel>--%>
        
         <div id="divImagepost" style="display: none;">
                        <div class="spinner" style="margin-left: -50px;margin-top: -49px;">
                            <div class="bounce1"></div>
                            <div class="bounce2"></div>
                            <div class="bounce3"></div>
                        </div>
                    </div>
        </div>
     </div>
     <div class="clearfix colelem" id="u594"><!-- group -->
      <div class="clearfix grpelem" id="u599"><!-- group -->
       <div class="clearfix grpelem" id="u600"><!-- group -->
        <div class="clearfix grpelem" id="pu603"><!-- column -->

         <div class="rounded-corners shadow colelem" id="u603"><!-- column -->
        
           <!-- simple frame -->
            <%--<asp:ScriptManager EnablePartialRendering="true"
 ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
                      <div>
 <asp:UpdatePanel ID="UpdatePanel1" style="margin-top: -12px;" runat="server"
 UpdateMode="Conditional">
 <ContentTemplate>
             <asp:ListView ID="ListView1" runat="server" OnItemDataBound="ListView1_ItemDataBound" DataKeyNames="PhotoID,LikeId,UserId,ContentType" DataSourceID="RacePostDataSource" OnItemCreated="ListView1_ItemCreated" OnItemCommand="ListView1_ItemCommand">
               
                <EditItemTemplate>
                    <span style="">
                    <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                   </span>
                    <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                         <asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("ContentType") %>' Visible="false" />
                            
                       <div class="colelem post_section_full_grid"><!-- post section -->
           <div class="position_content">
            <div class=" colelem post_profile_photo" style="
    margin-top: 0px;
">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("PostUserId") %>' />

            </div>

               <div class="post_top_info">

                   <asp:HyperLink ID="RacePostUserLabel" runat="server" Text='<%# Eval("UserFullName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' />
                   <br />
              
                   <asp:Label ID="RacePostDateLabel" runat="server" Text='<%# Eval("Date") %>' />
                   <br />
                         </div>
                   
            <div class="colelem post_section">
                    <asp:TextBox ID="RacePostTextBox" runat="server" Text='<%# Bind("Post") %>' Width="268" />
                   <br /></div>
               <div style="margin:10px">
               <asp:Button ID="UpdateButton" runat="server" CommandName="Updatepost" Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
               </div>
           </div>
                      <div class="like_dislike_share_section">
                      <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server" >Comment</asp:LinkButton>--%>
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                            <br />
                           <asp:Button ID="LinkViewAllComment" runat="server" style="border-width: 1px;width: 270px;background-color: #535461;color: white; border-radius: 5px;" Visible="true" Text="View all comments" CommandName="allcomment"></asp:Button>
                           </div>

          
                       <%--<div class="_u603 f3s_bot" id="_u603-f3s_bot"></div>--%>
                            </div>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <span>No data was returned.</span>
                </EmptyDataTemplate>
                <%--<InsertItemTemplate>
                    <span style="">RaceId:
                    <asp:TextBox ID="RaceIdTextBox" runat="server" Text='<%# Bind("RaceId") %>' />
                    <br />RacePost:
                    <asp:TextBox ID="RacePostTextBox" runat="server" Text='<%# Bind("RacePost") %>' />
                    <br />RacePostDate:
                    <asp:TextBox ID="RacePostDateTextBox" runat="server" Text='<%# Bind("RacePostDate") %>' />
                    <br />UserId:
                    <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                    <br />RaceContent:
                    <asp:TextBox ID="RaceContentTextBox" runat="server" Text='<%# Bind("RaceContent") %>' />
                    <br />RaceContentType:
                    <asp:TextBox ID="RaceContentTypeTextBox" runat="server" Text='<%# Bind("RaceContentType") %>' />
                    <br />RacePostUser:
                    <asp:TextBox ID="RacePostUserTextBox" runat="server" Text='<%# Bind("RacePostUser") %>' />
                    <br />
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                    <br /><br /></span>
                </InsertItemTemplate>--%>
                <ItemTemplate>
                 <%--   <asp:Panel runat="server" ID="items">
                        
                    <span style="" id="racepost" runat="server" title='<%# Eval("RaceId") %>'>--%>
                        <button runat="server" value='<%# Eval("PhotoID") %>' title='<%# Eval("SubCategory") %>' id="racepost" style="" class="race_post" onserverclick="racepost_ServerClick">
                        
                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                        <div class="colelem post_section_full_grid"><!-- post section -->
                   <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                         <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                            <asp:Label ID="PhotoIDLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                         <asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("ContentType") %>' Visible="false" />
                            
                       
           <div class="position_content">
            <div class=" colelem post_profile_photo" style="
    margin-top: 0px;
">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("PostUserId") %>' />

            </div>

               <div class="post_top_info">
                <div class="post_edit_delete" style="margin-right: -5px;margin-top: -2px;">
                           <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
                    <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you Sure you Want to delete ?"
                                        TargetControlID="DeleteButton">
                                    </ajaxToolkit:ConfirmButtonExtender>
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
                   <asp:HyperLink ID="RacePostUserLabel" runat="server" Text='<%# Eval("UserFullName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' />
                   <br />
              
                   <asp:Label ID="RacePostDateLabel" runat="server" Text='<%# Eval("Date") %>' />
                   <br />
                   <asp:Label ID="RacePostSubCategory" runat="server" Text='<%# Eval("SubCategory") %>' />
                         </div>
                   
            <div class="colelem post_section">
                Title: <asp:Label ID="Label1" runat="server" Text='<%# Eval("Title") %>' /><br />
                   <asp:Literal ID="RacePostLabel" runat="server" Text='<%# AddEmotes( Eval("Post").ToString()) %>' />
                   <br /></div>
               
           </div>
                      <div class="like_dislike_share_section">
                      <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server" >Comment</asp:LinkButton>--%>
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                            <br />
                           <asp:Button ID="LinkViewAllComment" runat="server" style="border-width: 1px;width: 270px;background-color: #535461;color: white; border-radius: 5px;" Visible="true" Text="View all comments" CommandName="allcomment"></asp:Button>
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
                            </button>
                        <asp:Panel ID="PanelPostComment" runat="server">
 <asp:ListView ID="ListViewPostComment" runat="server" DataKeyNames="PhotoID,LikeId,CommentUserId" DataSourceID="MediaDS" InsertItemPosition="LastItem" OnItemInserting="lvMediaComment_ItemInserting" OnItemCreated="ListViewPostComment_ItemCreated" OnItemCommand="ListViewPostComment_ItemCommand">
            
            <EditItemTemplate>
                <span style="">CommentId:
                <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                <br />
                RaceComment:
                <asp:TextBox ID="RaceCommentTextBox" class='animated' TextMode="MultiLine" style="width:200px" runat="server" Text='<%# Bind("RaceComment") %>' />
                <br />
                RaceCommentUser:
                <asp:TextBox ID="RaceCommentUserTextBox" runat="server" Text='<%# Bind("RaceCommentUser") %>' />
                <br />
                RaceCommentDate:
                <asp:TextBox ID="RaceCommentDateTextBox" runat="server" Text='<%# Bind("RaceCommentDate") %>' />
                <br />
                RaceId:
                <asp:TextBox ID="RaceIdTextBox" runat="server" Text='<%# Bind("PhotoID") %>' />
                <br />
                CommentContent:
                <asp:TextBox ID="CommentContentTextBox" runat="server" Text='<%# Bind("CommentContent") %>' />
                <br />
                CommentContentType:
                <asp:TextBox ID="CommentContentTypeTextBox" runat="server" Text='<%# Bind("CommentContentType") %>' />
                <br />
                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                <br /><br /></span>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <span>No Comments found.</span>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                  <%--<br />RaceCommentUser:
                <asp:TextBox ID="RaceCommentUserTextBox" runat="server" Text='<%# Bind("RaceCommentUser") %>' />--%>
                
                <%--<br />RaceId:
                <asp:TextBox ID="RaceIdTextBox" runat="server" Text='<%# Bind("RaceId") %>' />--%>
                <%--<br />CommentContent:
                <asp:TextBox ID="CommentContentTextBox" runat="server" Text='<%# Bind("CommentContent") %>' />--%>
               <%-- <br />CommentContentType:
                <asp:TextBox ID="CommentContentTypeTextBox" runat="server" Text='<%# Bind("CommentContentType") %>' />
                <br />--%>
                <asp:panel defaultbutton="InsertButton" runat="server">
                <span style="">
                   <div class="colelem comment_new_full">
                        <div class=" grpelem comment_new_profile_photo">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
                    

                        </div>
                <div class="comment_new_section" style="
    height: 88px;
">
                
                    <asp:TextBox ID="RaceCommentTextBox" class='animated' style="width:190px; height: 25px; margin-left: -5px;" placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" runat="server" TextMode="MultiLine" Text='<%# Bind("RaceComment") %>' />
                    <asp:Button ID="InsertButton" runat="server" style="margin-left: 139px;height: 30px;width: 70px;background-color: #26284f;color: white;" CommandName="Insert" Text="Comment" />
                </div>
              
                
               <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                </div>
                </span>
                    </asp:panel>
            </InsertItemTemplate>
            <ItemTemplate>
                <span style="">
                     <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                    <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />

                  
                 <div class="colelem comment_post_full">
                     <div class="position_content" >
           <div class=" grpelem comment_post_profile_photo">
                <asp:ImageButton ID="ImageProfile2" runat="server" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

           </div>
                        
                <div class="comment_post_info">
                <asp:HyperLink ID="RaceCommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' NavigateUrl='<%# Eval("CommentUserName","~/index_m.aspx?un={0}") %>' /><br />
                <asp:Label ID="RaceCommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                </div>
                    <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                     <div class="colelem comment_post_section">
                   <asp:Literal ID="RaceCommentLabel" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                   <br /></div>
                         </div>
                     <%--<div style="margin-top:40px;">--%>
                     <div class="comment_post_like_section">
              <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                       <%--<asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>
                       
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                         </div>
                          <%--</div>--%>
                            
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
            <%--<SelectedItemTemplate>
                <span style="">CommentId:
                <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' />
                <br />
                RaceComment:
                <asp:Label ID="RaceCommentLabel" runat="server" Text='<%# Eval("RaceComment") %>' />
                <br />
                RaceCommentUser:
                <asp:Label ID="RaceCommentUserLabel" runat="server" Text='<%# Eval("RaceCommentUser") %>' />
                <br />
                RaceCommentDate:
                <asp:Label ID="RaceCommentDateLabel" runat="server" Text='<%# Eval("RaceCommentDate") %>' />
                <br />
                RaceId:
                <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("RaceId") %>' />
                <br />
                CommentContent:
                <asp:Label ID="CommentContentLabel" runat="server" Text='<%# Eval("CommentContent") %>' />
                <br />
                CommentContentType:
                <asp:Label ID="CommentContentTypeLabel" runat="server" Text='<%# Eval("CommentContentType") %>' />
                <br />
<br /></span>
            </SelectedItemTemplate>--%>
       </asp:ListView>
                            </asp:Panel>
     <asp:SqlDataSource ID="RacePostCommentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [RaceComments] WHERE ([RaceId] = @RaceId) ORDER BY [RaceCommentDate]" OnSelecting="RacePostCommentDataSource_Selecting">
           <SelectParameters>
               <asp:Parameter Name="RaceId" Type="Object" />
           </SelectParameters>
       </asp:SqlDataSource>
                    
   
                 <%--   </span>
                    </asp:Panel>--%>
                </ItemTemplate>
                <LayoutTemplate>
                    <div id="itemPlaceholderContainer" runat="server" style="">
                        <span runat="server" id="itemPlaceholder" />
                    </div>
                    <div style="">
                    </div>
                </LayoutTemplate>
                <%--<SelectedItemTemplate>
                    <span style="">RaceId:
                    <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("RaceId") %>' />
                    <br />
                    RacePost:
                    <asp:Label ID="RacePostLabel" runat="server" Text='<%# Eval("RacePost") %>' />
                    <br />
                    RacePostDate:
                    <asp:Label ID="RacePostDateLabel" runat="server" Text='<%# Eval("RacePostDate") %>' />
                    <br />
                    UserId:
                    <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                    <br />
                    RaceContent:
                    <asp:Label ID="RaceContentLabel" runat="server" Text='<%# Eval("RaceContent") %>' />
                    <br />
                    RaceContentType:
                    <asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("RaceContentType") %>' />
                    <br />
                    RacePostUser:
                    <asp:Label ID="RacePostUserLabel" runat="server" Text='<%# Eval("RacePostUser") %>' />
                    <br />
<br /></span>
                </SelectedItemTemplate>--%>
            </asp:ListView>
         </div>
    
            
            <asp:SqlDataSource ID="RacePostDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="RacePostDataSource_Selecting" SelectCommand="SELECT * FROM [RacePosts]" >
               <%-- <SelectParameters>
                    <asp:Parameter Name="UserId" Type="Object" />
                    <asp:Parameter Name="Category" />
                </SelectParameters>--%>
            </asp:SqlDataSource>
      <asp:SqlDataSource ID="MediaDS" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [PhotoComments] WHERE ([PhotoID] = @PhotoID) ORDER BY [CommentDate]" OnSelecting="MediaDS_Selecting">
                 <SelectParameters>
                     <asp:Parameter Name="PhotoID" Type="Object" />
                     
                 </SelectParameters>
             </asp:SqlDataSource>
        </div>
     </ContentTemplate>
     <Triggers>

      <asp:AsyncPostBackTrigger ControlID="LoadMore" EventName="Click">

    </asp:AsyncPostBackTrigger>
          <asp:AsyncPostBackTrigger ControlID="btnNewPost" EventName="Click"></asp:AsyncPostBackTrigger>
        

   </Triggers>
 </asp:UpdatePanel>
     </div>

        <div class="clearfix grpelem" id="pu602"><!-- column -->

               <div>
 <asp:UpdatePanel ID="UpdatePanel2" style="margin-top: -2px;margin-left: 2px;" runat="server"
 UpdateMode="Conditional">
 <ContentTemplate>

         <div class="shadow colelem" id="u602" style="
    margin-left: -7px;
"><!-- group -->
                  
                <asp:ListView ID="ListView2" runat="server" DataKeyNames="PhotoID,LikeId,UserId,ContentType" OnItemDataBound="ListView2_ItemDataBound" DataSourceID="RaceMediaDataSource" OnItemCreated="ListView2_ItemCreated" OnItemCommand="ListView2_ItemCommand">
                    
                    <EditItemTemplate>
                        <span style="">
                        <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                      </span>
                        <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                             <asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("ContentType") %>'  Visible="false"/>

                               <div class="colelem post_section_full_grid" style="background-color:white;"><!-- post section -->
                   
                       
           <div class="position_content">
            <div class=" colelem post_profile_photo" style="
    margin-top: 0px;
">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("PostUserId") %>' />

            </div>

               <div class="post_top_info">
               <div class="post_edit_delete" style="margin-right: -5px;margin-top: -2px;">
                           <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
                     <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you Sure you Want to delete ?"
                                        TargetControlID="DeleteButton">
                                    </ajaxToolkit:ConfirmButtonExtender>  
                     </div>

                   <asp:HyperLink ID="RacePostUserLabel" runat="server" Text='<%# Eval("UserFullName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' />
                   <br />
              
                   <asp:Label ID="RacePostDateLabel" runat="server" Text='<%# Eval("Date") %>' />
                   <br />
                                      <asp:Label ID="RacePostSubCategory" runat="server" Text='<%# Eval("SubCategory") %>' />

                         </div>
                   
            
                 <div class="post_media_section">
                    <asp:Panel runat="server" Visible="false" ID="pnlVideo" style="height: 235px;">
                <video runat="server" id="videoplayer" style="height: 220px;width: 268px;" controls="controls" src='<%# Eval("SubCategory") %>'></video>
                       </asp:Panel>                   
                         <asp:ImageButton ID="imgbtn" runat="server" ImageUrl='<%# Eval("SubCategory") %>' Visible="false" style="
    margin-left: 35px;
" />



                    </div>
               <div class="colelem post_section">
                    <asp:TextBox ID="RacePostTextBox" runat="server" Text='<%# Bind("Description") %>' Width="268" BorderColor="Black" BorderStyle="Solid" BorderWidth="1" />
                   <br /></div>
               <div style="margin:10px">
               <asp:Button ID="UpdateButton" runat="server" CommandName="Updatepost" Text="Update" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" /></div>
           </div>
                      <div class="colelem like_dislike_share_section" style="background-color:#DEF0F4">
                      <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                    <%--   <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server" >Comment</asp:LinkButton>--%>
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                            <br />
                           <asp:Button ID="LinkViewAllComment" runat="server" style="border-width: 1px;width: 270px;background-color: #535461;color: white; border-radius: 5px;" Visible="true" Text="View all comments" CommandName="allcomment"></asp:Button>

                           </div>

          
                       <%--<div class="_u603 f3s_bot" id="_u603-f3s_bot"></div>--%>
                            </div>
                    </EditItemTemplate>
                    <EmptyDataTemplate>
                        <span>No data was returned.</span>
                    </EmptyDataTemplate>
                    <%--<InsertItemTemplate>
                        <span style="">RaceId:
                        <asp:TextBox ID="RaceIdTextBox" runat="server" Text='<%# Bind("RaceId") %>' />
                        <br />RacePost:
                        <asp:TextBox ID="RacePostTextBox" runat="server" Text='<%# Bind("RacePost") %>' />
                        <br />RacePostDate:
                        <asp:TextBox ID="RacePostDateTextBox" runat="server" Text='<%# Bind("RacePostDate") %>' />
                        <br />UserId:
                        <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                        <br />RaceContent:
                        <asp:TextBox ID="RaceContentTextBox" runat="server" Text='<%# Bind("RaceContent") %>' />
                        <br />RaceContentType:
                        <asp:TextBox ID="RaceContentTypeTextBox" runat="server" Text='<%# Bind("RaceContentType") %>' />
                        <br />RacePostUser:
                        <asp:TextBox ID="RacePostUserTextBox" runat="server" Text='<%# Bind("RacePostUser") %>' />
                        <br />
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                        <br /><br /></span>
                    </InsertItemTemplate>--%>
                    <ItemTemplate>
                        <asp:Panel runat="server" ID="items">
                              <span style="">
                             <button runat="server" value='<%# Eval("PhotoID") %>' title='<%# Eval("SubCategory") %>' id="racepost" class="race_post" onserverclick="racepost_ServerClick">
                      
                        <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                            <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                             <asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("ContentType") %>'  Visible="false"/>
                                 <asp:Label ID="PhotoIDLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />

                               <div class="colelem post_section_full_grid" style="background-color:white;"><!-- post section -->
                   
                       
           <div class="position_content">
            <div class=" colelem post_profile_photo" style="
    margin-top: 0px;
">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("PostUserId") %>' />

            </div>

               <div class="post_top_info">
               <div class="post_edit_delete" style="margin-right: -5px;margin-top: -2px;">
                           <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                              
                    <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
                    <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you Sure you Want to delete ?"
                                        TargetControlID="DeleteButton">
                                    </ajaxToolkit:ConfirmButtonExtender>
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

                   <asp:HyperLink ID="RacePostUserLabel" runat="server" Text='<%# Eval("UserFullName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' />
                   <br />
              
                   <asp:Label ID="RacePostDateLabel" runat="server" Text='<%# Eval("Date") %>' />
                   <br />
                                      <asp:Label ID="RacePostSubCategory" runat="server" Text='<%# Eval("SubCategory") %>' />

                         </div>
                   
            
                <div class="post_media_section">
                    <asp:Panel runat="server" Visible="false" ID="pnlVideo" style="height: 235px;">
                <video runat="server" id="videoplayer" style="height: 220px;width: 268px;" controls="controls" src='<%# Eval("ImageUrl") %>'></video>
                       </asp:Panel>     <a class='inline' href="#inline_content" runat="server" id="photo_popup">                  
                         <asp:ImageButton ID="imgbtn" Width="200" Height="200" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' Visible="false" style="    margin-left: 35px;" />

                                        </a>
<%--                          <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="MPEPopImage"  DropShadow="true"  BackgroundCssClass="modalBackgroundImage" Drag="false" runat="server" TargetControlID="imgbtn" PopupControlID="Panel1"></ajaxToolkit:ModalPopupExtender>--%>
                <div style='display:none'>
			<div id='inline_content' style='padding:10px; background:#fff;' runat="server">
                           <asp:Panel ID="Panel1" runat="server" style="margin-top: 50px;z-index: 10000; height: 500px; opacity: 1; box-shadow: rgb(0, 0, 0) 5px 5px 5px; background-color: white;">
                            <div style="float:left">
              <asp:Image Width="700" Height="500" ID="ImageButton2" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' />

                             </div>
                                   <div style="float:right;margin:20px;">
                                 <asp:Button ID="btnClose" runat="server" Text="X" style="margin-left: -735px;display: block;clear: both;width: 30px;height: 30px;border-radius: 300px;margin-top: -34px;border: 6px solid rgb(242, 243, 244);background: rgb(204, 222, 232);color: rgb(10, 22, 45);font-weight: bold;margin-top: -38px;" />
                           <asp:ImageButton ID="Image2" runat="server" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' Style="vertical-align:top" />
<%--                                            <asp:HyperLink ID="FullNameLabel" runat="server" Text='<%# Eval("FirstName") %>' NavigateUrl='<%# Eval("UserId","~/profile-list_search.aspx?userid={0}") %>' />--%>
                                                      <asp:HyperLink ID="HyperLink2" runat="server" Text='<%# Eval("UserFullName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' /> 
<br />
                       
                                <asp:Label ID="DateCreatedLabel" runat="server" style="display: block;margin-left: 56px;margin-top: -16px;" Text='<%# Eval("Date") %>' /><br />
                                <asp:Label ID="Label3" runat="server" style="margin-bottom: 20px;display: block;margin-top: 5px;" Text='<%# Eval("Description") %>' /><br />
   <asp:ListView ID="ListView3" runat="server" DataKeyNames="RaceId,LikeId,CommentUserId" DataSourceID="RaceMediaCommentDataSource" InsertItemPosition="LastItem" OnItemInserting="ListViewMediaComment_ItemInserting" OnItemCreated="ListViewMediaComment_ItemCreated" OnItemCommand="ListViewMediaComment_ItemCommand">
                     
                     <EditItemTemplate>
                         <span style="">CommentId:
                         <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                         <br />
                         RaceComment:
                         <asp:TextBox ID="RaceCommentTextBox" class='animated' TextMode="MultiLine" style="width:200px" runat="server" Text='<%# Bind("RaceComment") %>' />
                         <br />
                         RaceCommentUser:
                         <asp:TextBox ID="RaceCommentUserTextBox" runat="server" Text='<%# Bind("RaceCommentUser") %>' />
                         <br />
                         RaceCommentDate:
                         <asp:TextBox ID="RaceCommentDateTextBox" runat="server" Text='<%# Bind("RaceCommentDate") %>' />
                         <br />
                         RaceId:
                         <asp:TextBox ID="RaceIdTextBox" runat="server" Text='<%# Bind("RaceId") %>' />
                         <br />
                         CommentContent:
                         <asp:TextBox ID="CommentContentTextBox" runat="server" Text='<%# Bind("CommentContent") %>' />
                         <br />
                         CommentContentType:
                         <asp:TextBox ID="CommentContentTypeTextBox" runat="server" Text='<%# Bind("CommentContentType") %>' />
                         <br />
                         <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                         <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                         <br /><br /></span>
                     </EditItemTemplate>
                     <EmptyDataTemplate>
                         <span>No Comments found.</span>
                     </EmptyDataTemplate>
                     <InsertItemTemplate>
                          <asp:panel defaultbutton="InsertButton" runat="server">
                         <span style=""> 
                             <div class="colelem comment_new_full">
                        <div class=" grpelem comment_new_profile_photo">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
                    

                        </div>
                <div class="comment_new_section" style="
    height: 88px;
">
<asp:TextBox ID="RaceCommentTextBox" class='animated' style="width:190px; height: 25px; margin-left: -5px;" placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" runat="server" TextMode="MultiLine" Text='<%# Bind("RaceComment") %>' />  
                    <asp:Button ID="InsertButton" runat="server" style="margin-left: 139px;height: 30px;width: 70px;background-color: #26284f;color: white;" CommandName="Insert" Text="Comment" />
                </div>
              
                
               <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                </div>
                         </span>
                              </asp:panel>
                     </InsertItemTemplate>
                     <ItemTemplate>
                         <span style="">
                            <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                             <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("RaceId") %>' Visible="false" />

                  
                 <div class="colelem comment_post_full">
                     <div class="position_content" >
           <div class=" grpelem comment_post_profile_photo">
                <asp:ImageButton ID="ImageProfile2" runat="server" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

           </div>
                        
                <div class="comment_post_info">
                <asp:HyperLink ID="RaceCommentUserLabel" runat="server" Text='<%# Eval("RaceCommentUser") %>' NavigateUrl='<%# Eval("RaceCommentUserName","~/index_m.aspx?un={0}") %>' />
                         <br />                         
                         <asp:Label ID="RaceCommentDateLabel" runat="server" Text='<%# Eval("RaceCommentDate") %>' />
                </div>
                    <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                     <div class="colelem comment_post_section">
                  <asp:Literal ID="RaceCommentLabel" runat="server" Text='<%# AddEmotes( Eval("RaceComment").ToString()) %>' />
                   <br /></div>
                         </div>
                     <%--<div style="margin-top:40px;">--%>
                     <div class="comment_post_like_section">
              <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                     <%--  <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>
                       
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                         </div>
                          <%--</div>--%>
                            
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
                         RaceComment:
                         <asp:Label ID="RaceCommentLabel" runat="server" Text='<%# Eval("RaceComment") %>' />
                         <br />
                         RaceCommentUser:
                         <asp:Label ID="RaceCommentUserLabel" runat="server" Text='<%# Eval("RaceCommentUser") %>' />
                         <br />
                         RaceCommentDate:
                         <asp:Label ID="RaceCommentDateLabel" runat="server" Text='<%# Eval("RaceCommentDate") %>' />
                         <br />
                         RaceId:
                         <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("RaceId") %>' />
                         <br />
                         CommentContent:
                         <asp:Label ID="CommentContentLabel" runat="server" Text='<%# Eval("CommentContent") %>' />
                         <br />
                         CommentContentType:
                         <asp:Label ID="CommentContentTypeLabel" runat="server" Text='<%# Eval("CommentContentType") %>' />
                         <br />
<br /></span>
                     </SelectedItemTemplate>
             </asp:ListView>
                                </div>
                             
                                
                                </asp:Panel>
                </div></div>
                    </div>
               <div class="colelem post_section">
                  Title: <asp:Label ID="Label2" runat="server" Text='<%# Eval("Title") %>' /><br />
                   <asp:Literal ID="RacePostLabel" runat="server" Text='<%# AddEmotes( Eval("Description").ToString()) %>' /><br />
                                          <asp:HyperLink  CssClass="one" ID="HyperLink1" NavigateUrl='<%# Eval("Link") %>' runat="server"><%# Eval("Link") %></asp:HyperLink>

                   <br /></div>
               
           </div>
                      <div class="colelem like_dislike_share_section" style="background-color:#DEF0F4">
                      <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                    <%--   <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server" >Comment</asp:LinkButton>--%>
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                            <br />
                           <asp:Button ID="LinkViewAllComment" runat="server" style="border-width: 1px;width: 270px;background-color: #535461;color: white; border-radius: 5px;" Visible="true" Text="View all comments" CommandName="allcomment"></asp:Button>
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
                            </button>
                            <asp:Panel ID="PanelMediaComment" runat="server">
   <asp:ListView ID="ListViewMediaComment" runat="server" DataKeyNames="PhotoID,LikeId,CommentUserId" DataSourceID="MediaDS" InsertItemPosition="LastItem" OnItemInserting="lvMediaComment_ItemInserting" OnItemCreated="ListViewMediaComment_ItemCreated" OnItemCommand="ListViewMediaComment_ItemCommand">
                     
                     <EditItemTemplate>
                         <span style="">CommentId:
                         <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                         <br />
                         RaceComment:
                         <asp:TextBox ID="RaceCommentTextBox" class='animated' TextMode="MultiLine" style="width:200px" runat="server" Text='<%# Bind("Comment") %>' />
                         <br />
                         RaceCommentUser:
                         <asp:TextBox ID="RaceCommentUserTextBox" runat="server" Text='<%# Bind("CommentUser") %>' />
                         <br />
                         RaceCommentDate:
                         <asp:TextBox ID="RaceCommentDateTextBox" runat="server" Text='<%# Bind("CommentDate") %>' />
                         <br />
                         RaceId:
                         <asp:TextBox ID="RaceIdTextBox" runat="server" Text='<%# Bind("PhotoID") %>' />
                         <br />
                         CommentContent:
                         <asp:TextBox ID="CommentContentTextBox" runat="server" Text='<%# Bind("CommentContent") %>' />
                         <br />
                         CommentContentType:
                         <asp:TextBox ID="CommentContentTypeTextBox" runat="server" Text='<%# Bind("CommentContentType") %>' />
                         <br />
                         <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                         <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                         <br /><br /></span>
                     </EditItemTemplate>
                     <EmptyDataTemplate>
                         <span>No Comments found.</span>
                     </EmptyDataTemplate>
                     <InsertItemTemplate>
                          <asp:panel defaultbutton="InsertButton" runat="server">
                         <span style=""> 
                             <div class="colelem comment_new_full">
                        <div class=" grpelem comment_new_profile_photo">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
                    

                        </div>
                <div class="comment_new_section" style="
    height: 88px;
">
<asp:TextBox ID="RaceCommentTextBox" class='animated' style="width:190px; height: 25px; margin-left: -5px;" placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" runat="server" TextMode="MultiLine" Text='<%# Bind("RaceComment") %>' />  
                    <asp:Button ID="InsertButton" runat="server" style="margin-left: 139px;height: 30px;width: 70px;background-color: #26284f;color: white;" CommandName="Insert" Text="Comment" />
                </div>
              
                
               <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                </div>
                         </span>
                              </asp:panel>
                     </InsertItemTemplate>
                     <ItemTemplate>
                         <span style="">
                            <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                             <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />

                  
                 <div class="colelem comment_post_full">
                     <div class="position_content" >
           <div class=" grpelem comment_post_profile_photo">
                <asp:ImageButton ID="ImageProfile2" runat="server" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

           </div>
                        
                <div class="comment_post_info">
                <asp:HyperLink ID="RaceCommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' NavigateUrl='<%# Eval("CommentUserName","~/index_m.aspx?un={0}") %>' />
                         <br />                         
                         <asp:Label ID="RaceCommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                </div>
                    <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                     <div class="colelem comment_post_section">
                  <asp:Literal ID="RaceCommentLabel" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                   <br /></div>
                         </div>
                     <%--<div style="margin-top:40px;">--%>
                     <div class="comment_post_like_section">
              <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                     <%--  <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>
                       
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                            <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                         </div>
                          <%--</div>--%>
                            
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
                     <%--<SelectedItemTemplate>
                         <span style="">CommentId:
                         <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' />
                         <br />
                         RaceComment:
                         <asp:Label ID="RaceCommentLabel" runat="server" Text='<%# Eval("RaceComment") %>' />
                         <br />
                         RaceCommentUser:
                         <asp:Label ID="RaceCommentUserLabel" runat="server" Text='<%# Eval("RaceCommentUser") %>' />
                         <br />
                         RaceCommentDate:
                         <asp:Label ID="RaceCommentDateLabel" runat="server" Text='<%# Eval("RaceCommentDate") %>' />
                         <br />
                         RaceId:
                         <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("RaceId") %>' />
                         <br />
                         CommentContent:
                         <asp:Label ID="CommentContentLabel" runat="server" Text='<%# Eval("CommentContent") %>' />
                         <br />
                         CommentContentType:
                         <asp:Label ID="CommentContentTypeLabel" runat="server" Text='<%# Eval("CommentContentType") %>' />
                         <br />
<br /></span>
                     </SelectedItemTemplate>--%>
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
                        <span style="">RaceId:
                        <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("RaceId") %>' />
                        <br />
                        RacePost:
                        <asp:Label ID="RacePostLabel" runat="server" Text='<%# Eval("RacePost") %>' />
                        <br />
                        RacePostDate:
                        <asp:Label ID="RacePostDateLabel" runat="server" Text='<%# Eval("RacePostDate") %>' />
                        <br />
                        UserId:
                        <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                        <br />
                        RaceContent:
                        <asp:Label ID="RaceContentLabel" runat="server" Text='<%# Eval("RaceContent") %>' />
                        <br />
                        RaceContentType:
                        <asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("RaceContentType") %>' />
                        <br />
                        RacePostUser:
                        <asp:Label ID="RacePostUserLabel" runat="server" Text='<%# Eval("RacePostUser") %>' />
                        <br />
<br /></span>
                    </SelectedItemTemplate>--%>
             </asp:ListView>
             <asp:SqlDataSource ID="RaceMediaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="RaceMediaDataSource_Selecting" SelectCommand="SELECT * FROM [RacePosts] ">
                <%-- <SelectParameters>
                     <asp:Parameter Name="UserId" Type="Object" />
                 </SelectParameters>--%>
             </asp:SqlDataSource>
         </div>
        <%-- <div class="shadow colelem" id="u606"><!-- group -->
          <div class="_u606 f3s_top" id="_u606-f3s_top"></div>
          <div class="_u606 f3s_mid clearfix" id="_u606-f3s_mid">
           <div class="museBGSize grpelem" id="u604"><!-- simple frame --></div>
          </div>
          <div class="_u606 f3s_bot" id="_u606-f3s_bot"></div>--%>
                 
             <asp:SqlDataSource ID="RaceMediaCommentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [RaceComments] WHERE ([RaceId] = @RaceId) ORDER BY [RaceCommentDate]" OnSelecting="RaceMediaCommentDataSource_Selecting">
                 <SelectParameters>
                     <asp:Parameter Name="RaceId" Type="Object" />
                 </SelectParameters>
             </asp:SqlDataSource>

      </ContentTemplate>
     <Triggers>

      <asp:AsyncPostBackTrigger ControlID="LoadMore" EventName="Click">

    </asp:AsyncPostBackTrigger>
          <asp:AsyncPostBackTrigger ControlID="btnNewPost" EventName="Click"></asp:AsyncPostBackTrigger>

   </Triggers>
 </asp:UpdatePanel>
     </div>


         </div>
               <div class="clearfix colelem">
             <asp:Button ID="LoadMore" runat="server" Height="28px" Text="Load More..." Width="300" style="display:none" OnClick="LoadMore_Click" />
            <div id="divImage" style="display:none">
                <div class="spinner">
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
      
       <%--<div class="clearfix grpelem" id="u612-4"><!-- content -->
        <p>Comment</p>
       </div>--%>
      </div>
     <%-- <div class="clearfix grpelem" id="pu615"><!-- group -->
      
      </div>--%>
          <div class="clearfix grpelem" id="divider_right_race" style="
    margin-left: 590px;
"><!-- column -->
              <div id="listgrid_bar" style="width: 135px;	margin-left: 18px; margin-top: -35px;	position: relative;    float:left;">
         <asp:ImageButton ID="ImageButtonGrid" runat="server" CssClass="" ImageUrl="~/images/icon/black/horizontal20.png" OnClick="ImageButtonGrid_Click" Height="40px" Width="40px"   />
             <asp:ImageButton ID="ImageButtonList" runat="server" CssClass="" ImageUrl="~/images/icon/black/six15.png" OnClick="ImageButtonList_Click" Height="40px" Width="40px"   />
            
             
           <asp:ImageButton ID="btnChangeBackground" OnClientClick="$('html').css('overflow', 'hidden');" runat="server" Height="40" Width="40" Text="Change Background" ImageUrl="~/images/icon/black/photo146.png"  />

      <asp:Panel ID="pnChangeBackground" runat="server" CssClass="popup2" Style="display:none;">
         
                Choose Your Background:<br />
              
          <ajaxToolkit:AjaxFileUpload ID="AjaxFileUpload1" runat="server" OnUploadComplete="AjaxFileUpload1_UploadComplete" 

OnClientUploadComplete="OnClientUploadComplete" MaximumNumberOfFiles="1" AllowedFileTypes="jpg,jpeg,tiff,png,gif"/>

        <asp:Button ID="btnbckcancel" runat="server" Text="Cancel" />
            
        </asp:Panel>
        <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="ModalPopupExtender2" runat="server" PopupControlID="pnChangeBackground" 

TargetControlID="btnChangeBackground"                                      
             DropShadow="true" BackgroundCssClass="modalBackground" CancelControlID="btnbckcancel"
            Drag="false">
             <Animations>
     <OnShown><Fadein Duration="0.50" /></OnShown>
            <OnHiding><Fadeout Duration="0.75" /></OnHiding>
    </Animations>
        </ajaxToolkit:ModalPopupExtender>
             
             
              </div>
          <div class="clearfix colelem" id="side_menu" style="
    margin-top: 80px;
"><!-- group -->
       <div class="clearfix grpelem" id="side_menu_bar" style="
    margin-top: 65px; margin-left:5px;
"><!-- column -->
        <asp:Button ID="btnMyIweu" runat="server" Text="My Iweu" CssClass="sidecatmenu" OnClick="btnMyIweu_Click"  />
          <asp:Button ID="btnRankInfo" runat="server" Text="Rank Info" CssClass="sidecatmenu" OnClick="btnRankInfo_Click"  />
           <asp:Button ID="btnPointCurrent" runat="server" Text="Point Overview (Current)" CssClass="sidecatmenu" OnClick="btnPointCurrent_Click"  />
          <asp:Button ID="btnPointAll" runat="server" Text="Point Overview (All)" CssClass="sidecatmenu" OnClick="btnPointAll_Click"  />
          <asp:Button ID="btnAdvertisement" runat="server" Text="Advertisement" CssClass="sidecatmenu" />
          <asp:Button ID="btnMyActivity" runat="server" Text="My Activity" CssClass="sidecatmenu" OnClick="btnMyActivity_Click"  />
           <asp:Button ID="btnFollowers" runat="server" Text="Followers" CssClass="sidecatmenu"  />
          
       </div>
</div>
       
      </div>
    </div>
        
    
   </div>
  </div>
</asp:Content>

