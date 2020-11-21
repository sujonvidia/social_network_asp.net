<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="raceActivity.aspx.cs" Inherits="Default3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" type="text/css" href="css/race-list.css?4045527434" id="pagesheet4"/>
    <link rel="stylesheet" type="text/css" href="css/master.css" id="pagesheet4"/>
    <link rel="stylesheet" type="text/css" href="css/race.css"/>
     <script src="js/jquery.js"></script>
    <script src="js/ajaxupload-min.js"></script>
<%--    <link href="css/baseTheme/style.css" rel="stylesheet" media="all" />--%>
   
    <link href="css/classicTheme/style.css" rel="stylesheet" media="all" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_top_menu" Runat="Server">
      <asp:Menu ID="MenuSub" runat="server" Orientation="Horizontal" BorderStyle="Double" CssClass="Menu" BackColor="#32374B">
            <Items>
                <asp:MenuItem Text="All Ranks" Value="All Ranks"></asp:MenuItem>
                <asp:MenuItem Text="Novice" Value="Novice"></asp:MenuItem>
                <asp:MenuItem Text="Advanced" Value="Advanced"></asp:MenuItem>
                <asp:MenuItem Text="Elite" Value="Elite"></asp:MenuItem>
                <asp:MenuItem Text="Super" Value="Super"></asp:MenuItem>
                <asp:MenuItem Text="+" Value="+"></asp:MenuItem>
            </Items>
        </asp:Menu>
    <asp:Menu ID="MenuMain" style="float: left; background-color: rgb(82, 84, 97);margin-left: 5px;width: 70px;-moz-border-radius: 0px 0px 5px 5px ;-webkit-border-radius: 0px 0px 5px 5px ;-khtml-border-radius: 0px 0px 5px 5px ;border-radius: 0px 0px 5px 5px ;" runat="server" ForeColor="White" OnMenuItemClick="MenuMain_MenuItemClick">
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
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="clearfix colelem" id="u1325"><!-- column -->
     <div class="clearfix colelem post_new_up_full"><!-- group -->
      <div class="museBGSize grpelem">
           <asp:Image ID="ImageProfile" runat="server" Width="130px" Height="116px" CssClass="profilephotoborder" />
      </div>
      <div class="shadow clearfix grpelem" id="post_item"><!-- group -->
         <div style="float:right;margin-bottom:10px">
             <asp:ImageButton ID="ImageButton3" CssClass="icon" runat="server" ImageUrl="~/images/icon/black/tag.png" Width="20" Height="20" />
                 <asp:ImageButton ID="ImageButton4" CssClass="icon" runat="server" ImageUrl="~/images/icon/black/location.png" Width="20" />
           
                 <a onclick="clk();"> <img class="icon" src="images/icon/black/attach.png" width="20"/></a>
                 
<%--                 <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/icon/black/attach.png" Width="20" OnClientClick=" clk();" />--%>
                 <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/images/icon/black/emoticon.png" Width="20" Visible="false" />
             </div>
      <asp:TextBox ID="txtNewPost" runat="server" Columns="40" Rows="2" style="overflow:hidden" onkeyup="setHeight(this)" TextMode="MultiLine" Width="425px" EnableViewState="False"></asp:TextBox>
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
         
             <div style="float:right; display:inline;margin-top:10px">
            
                      <asp:ImageButton ID="btnNewPost" CssClass="icon" runat="server" Text="Post" ImageUrl="~/images/icon/black/post.png" Width="20" OnClick="btnNewPost_Click" EnableViewState="False"  />
                   <ajaxToolkit:AnimationExtender ID="ae" runat="server" TargetControlID="btnNewPost">
                              <Animations>
 <OnClick>
 <Sequence>
 <EnableAction Enabled="false" />
 <Parallel>
 <FadeOut Duration="1.5" Fps="24" AnimationTarget="UpdatePanel1" />
     <FadeIn Duration="1.5" Fps="24" AnimationTarget="UpdatePanel1" />
    
 
 </Parallel>
      <EnableAction Enabled="true" />
 </Sequence>
 </OnClick>
 </Animations> </ajaxToolkit:AnimationExtender>
            
        </div>

        
                  <div style="float:right; display:none;"><asp:FileUpload ID="FileUpload1" runat="server" /></div>
     </div>
      
     </div>
         
     <div class="clearfix colelem" id="u594"><!-- group -->
      <div class="clearfix grpelem" id="u599"><!-- group -->
       <div class="clearfix grpelem" id="u600"><!-- group -->
        <div class="clearfix grpelem" id="pu603"><!-- column -->

         <div class="rounded-corners shadow colelem" id="u603"><!-- column -->

           <!-- simple frame -->
         <%--   <asp:ScriptManager EnablePartialRendering="true"
 ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
                      <div>
 <asp:UpdatePanel ID="UpdatePanel1" runat="server"
 UpdateMode="Conditional" ChildrenAsTriggers="true">
 <ContentTemplate>
             <asp:ListView ID="ListView1" runat="server" DataKeyNames="RaceId,LikeId,UserId" DataSourceID="RacePostDataSource" OnItemDataBound="ListView1_ItemDataBound" OnItemCreated="ListView1_ItemCreated" OnItemCommand="ListView1_ItemCommand">
               
                <EditItemTemplate>
                    <span style="">
                    <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("RaceId") %>' Visible="false" />
                   
                   
                   <%-- <br />
                    RacePostDate:
                    <asp:TextBox ID="RacePostDateTextBox" runat="server" Text='<%# Bind("RacePostDate") %>' />
                    <br />
                    UserId:
                    <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                    <br />
                    RaceContent:
                    <asp:TextBox ID="RaceContentTextBox" runat="server" Text='<%# Bind("RaceContent") %>' />
                    <br />
                    RaceContentType:
                    <asp:TextBox ID="RaceContentTypeTextBox" runat="server" Text='<%# Bind("RaceContentType") %>' />
                    <br />
                    RacePostUser:
                    <asp:TextBox ID="RacePostUserTextBox" runat="server" Text='<%# Bind("RacePostUser") %>' />
                    <br />--%>
                    
                    <br /><br /></span>
                    <asp:Panel id="post_backcolor" runat="server" class="colelem post_section_full_list">
                   <asp:Label ID="Label1" runat="server" Text='<%# Eval("RaceId") %>' Visible="false" />
                         <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                         <asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("RaceContentType") %>' Visible="false" />
                       
           <div class="position_content">
            <div class=" colelem post_profile_photo">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' />

            </div>

               <div class="post_top_info">
               <div class="post_edit_delete" style="margin-right: -15px;">
                           <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
                       </div>
                   <asp:Label ID="RacePostUserLabel" runat="server" Text='<%# Eval("RacePostUser") %>' />
                   <br />
              
                   <asp:Label ID="RacePostDateLabel" runat="server" Text='<%# Eval("RacePostDate") %>' />
                   <br />
                         </div>
               <div class="post_media_section">
                    
                <embed id='embed1' autostart='false' runat="server" name='mediaPlayer' type='application/x-mplayer2' pluginspage='http://microsoft.com/windows/mediaplayer/en/download/'  displaysize='4' autosize='-1' bgcolor='darkblue' showcontrols='true' showtracker='-1' showdisplay='0' showstatusbar='-1' videoborder3d='-1' width='200' height='200'  designtimesp='5311' loop='false' src='<%# "ThumbnailHandlerRaceMedia.ashx?raceid=" + Eval("RaceId") %>' visible="false"/>
                </div>
                   
            <div class="colelem post_section_list">
                    <asp:TextBox ID="RacePostTextBox" runat="server" Text='<%# Bind("RacePost") %>' BorderWidth="1" BorderStyle="Solid" BorderColor="Black" onkeyup="setHeight(this)" Width="573" TextMode="MultiLine" />
                   <br /></div>
               <div style="margin:10px">
               <asp:Button ID="UpdateButton" runat="server" CommandName="Updatepost" Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" /></div>
           </div>
                      <div class="colelem like_dislike_share_section_list">
                      <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server">Comment</asp:LinkButton>--%>
                          <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                       

                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            
                            <br />
                           <asp:Button ID="LinkViewAllComment" runat="server" Visible="true" Text="View all comments" CommandName="allcomment"></asp:Button>
                           </div>

          
                       <%--<div class="_u603 f3s_bot" id="_u603-f3s_bot"></div>--%>
                            </asp:Panel>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <span>No data was returned.</span>
                </EmptyDataTemplate>
                <InsertItemTemplate>
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
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Panel runat="server" id="items" >
                    <span style="">
                        <asp:Panel id="post_backcolor" runat="server" class="colelem post_section_full_list">
                   <asp:Label ID="RaceIdLabel" runat="server" Text='<%# Eval("RaceId") %>' Visible="false" />
                         <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                         <asp:Label ID="RaceContentTypeLabel" runat="server" Text='<%# Eval("RaceContentType") %>' Visible="false" />
                       
           <div class="position_content">
            <div class=" colelem post_profile_photo">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' />

            </div>

               <div class="post_top_info">
               <div class="post_edit_delete" style="margin-right: -15px;">
                           <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
                   <ajaxToolkit:AnimationExtender ID="AnimationExtender3" runat="server" TargetControlID="DeleteButton">
            <Animations>
       <OnClick>

        
            <Parallel AnimationTarget="items" Duration="1" Fps="30">
                <FadeOut AnimationTarget="items" Fps="30" />
                
            </Parallel>
           
           </OnClick>
            </Animations>
        </ajaxToolkit:AnimationExtender>
                       </div>
                   <asp:Label ID="RacePostUserLabel" runat="server" Text='<%# Eval("RacePostUser") %>' />
                   <br />
              
                   <asp:Label ID="RacePostDateLabel" runat="server" Text='<%# Eval("RacePostDate") %>' />
                   <br />
                    <asp:Label ID="RacePostSubCategory" runat="server" Text='<%# Eval("SubCategory") %>' />
                         </div>
               <div class="post_media_section">
                    
                <embed id='embed1' autostart='false' runat="server" name='mediaPlayer' type='application/x-mplayer2' pluginspage='http://microsoft.com/windows/mediaplayer/en/download/'  displaysize='4' autosize='-1' bgcolor='darkblue' showcontrols='true' showtracker='-1' showdisplay='0' showstatusbar='-1' videoborder3d='-1' width='200' height='200'  designtimesp='5311' loop='false' src='<%# "ThumbnailHandlerRaceMedia.ashx?raceid=" + Eval("RaceId") %>' visible="false"/>
                </div>
                   
            <div class="colelem post_section_list">
                   <asp:Literal ID="RacePostLabel" runat="server" Text='<%# AddEmotes( Eval("RacePost").ToString()) %>' />
                   <br /></div>
               
           </div>
                      <div class="colelem like_dislike_share_section_list">
                      <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server">Comment</asp:LinkButton>--%>
                          <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                       

                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            
                            <br />
                           <asp:Button ID="LinkViewAllComment" runat="server" Visible="true" Text="View all comments" CommandName="allcomment"></asp:Button>
                          <ajaxToolkit:AnimationExtender ID="AnimationExtender1" runat="server" TargetControlID="LinkViewAllComment">
            <Animations>
       <OnClick>

        
            <Parallel AnimationTarget="PanelComment" Duration="3" Fps="25">
                <FadeOut AnimationTarget="PanelComment" minimumOpacity=".1" Fps="30" />
                <FadeIn AnimationTarget="PanelComment" minimumOpacity=".1" Fps="30" />  
            </Parallel>
           
           </OnClick>
            </Animations>
        </ajaxToolkit:AnimationExtender>
                           </div>

          
                       <%--<div class="_u603 f3s_bot" id="_u603-f3s_bot"></div>--%>
                            </asp:Panel>
                        <asp:Panel ID="PanelComment" runat="server">
 <asp:ListView ID="ListViewPostComment" runat="server" DataKeyNames="RaceId,LikeId,CommentUserId" DataSourceID="RacePostCommentDataSource" InsertItemPosition="LastItem" OnItemInserting="ListViewPostComment_ItemInserting" OnItemCreated="ListViewPostComment_ItemCreated" OnItemCommand="ListViewPostComment_ItemCommand">
            
            <EditItemTemplate>
                <span style="">CommentId:
                <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                <br />
                RaceComment:
                <asp:TextBox ID="RaceCommentTextBox" runat="server" Text='<%# Bind("RaceComment") %>' />
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
                   <div class="colelem comment_new_full2">
                        <div class=" grpelem comment_new_profile_photo">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
                    

                        </div>
                <div class="comment_new_section">
                
                    <asp:TextBox ID="RaceCommentTextBox" runat="server" Text='<%# Bind("RaceComment") %>' onkeyup="setHeight(this)" Width="500" />
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Comment" />
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

                  
                 <div class="colelem comment_post_full" style="width: 593px;">
                     <div class="position_content" >
           <div class=" grpelem comment_post_profile_photo">
                <asp:ImageButton ID="ImageProfile2" runat="server" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

           </div>
                        
                <div class="comment_post_info">
                <asp:Label ID="RaceCommentUserLabel" runat="server" Text='<%# Eval("RaceCommentUser") %>' /><br />
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
                            </asp:Panel>
     <asp:SqlDataSource ID="RacePostCommentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [RaceComments] WHERE ([RaceId] = @RaceId) ORDER BY [RaceCommentDate]" OnSelecting="RacePostCommentDataSource_Selecting">
           <SelectParameters>
               <asp:Parameter Name="RaceId" Type="Object" />
           </SelectParameters>
       </asp:SqlDataSource>
    
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
                </SelectedItemTemplate>
            </asp:ListView>
      
     <div style="width: 600px ;  margin-left: auto ;  margin-right: auto ;position:relative;top:15px">
     <div id="divImage" style="display:none" >
      <div class="spinner">
  <div class="bounce1"></div>
  <div class="bounce2"></div>
  <div class="bounce3"></div>
</div>
     </div>
                  </div>
     
         </div>
       <%--  <div class="shadow colelem" id="u608"><!-- group -->
             
          <div class="_u608 f3s_top" id="_u608-f3s_top"></div>
          <div class="_u608 f3s_mid clearfix" id="_u608-f3s_mid">
           <div class="museBGSize grpelem" id="u607"><!-- simple frame --></div>
          </div>
          <div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>
             
         </div>--%>
            
            
        </div>
     </ContentTemplate>
     <Triggers>

      <asp:AsyncPostBackTrigger ControlID="LoadMore" EventName="Click">

    </asp:AsyncPostBackTrigger>

   </Triggers>
 </asp:UpdatePanel>
                          <asp:SqlDataSource ID="RacePostDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="RacePostDataSource_Selecting" SelectCommand="SELECT * FROM [RacePosts]" >
               <%-- <SelectParameters>
                    <asp:Parameter Name="UserId" Type="Object" />
                    <asp:Parameter Name="Category" />
                </SelectParameters>--%>
            </asp:SqlDataSource>
                          
     </div>
 
        
        </div>
           
            <asp:Button ID="LoadMore" runat="server" Height="28px" Text="Load More..." Width="300" OnClick="LoadMore_Click" style="display:none"/>
            <ajaxToolkit:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender1"
        TargetControlID="UpdatePanel1" runat="server">
        <Animations>
            <OnUpdating>
               <Parallel duration="0">
                    <ScriptAction Script="onUpdating();" />
                    <EnableAction AnimationTarget="LoadMore" Enabled="false" />                   
                </Parallel>
            </OnUpdating>
            <OnUpdated>
                <Parallel duration="0">
                    <ScriptAction Script="onUpdated();" />
                    <EnableAction AnimationTarget="LoadMore" Enabled="true" />
                </Parallel>
            </OnUpdated>
        </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>
              
       </div>
      
       <%--<div class="clearfix grpelem" id="u612-4"><!-- content -->
        <p>Comment</p>
       </div>--%>
          
      </div>
     <%-- <div class="clearfix grpelem" id="pu615"><!-- group -->
      
      </div>--%>
          
          <div class="clearfix grpelem" id="divider_right_race"><!-- column -->
              <div id="listgrid_bar" style="width: 135px;	margin-left: 18px; margin-top: 30px;	position: relative;    float:left;">
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
        </ajaxToolkit:ModalPopupExtender>
             
             
              </div>
          <div class="clearfix colelem" id="side_menu"><!-- group -->
       <div class="clearfix grpelem" id="side_menu_bar" ><!-- column -->
        <asp:Button ID="btnMyIweu" runat="server" Text="My Iweu" CssClass="sidecatmenu" OnClick="btnMyIweu_Click"  />
          <asp:Button ID="btnRankInfo" runat="server" Text="Rank Info" CssClass="sidecatmenu"  />
           <asp:Button ID="btnPointCurrent" runat="server" Text="Point Overview (Current)" CssClass="sidecatmenu" OnClick="btnPointCurrent_Click"  />
          <asp:Button ID="btnPointAll" runat="server" Text="Point Overview (All)" CssClass="sidecatmenu" OnClick="btnPointAll_Click"  />
          <asp:Button ID="btnAdvertisement" runat="server" Text="Advertisement" CssClass="sidecatmenu" />
          <asp:Button ID="btnMyActivity" runat="server" Text="My Activity" CssClass="sidecatmenu"  />
           <asp:Button ID="btnFollowers" runat="server" Text="Followers" CssClass="sidecatmenu"  />
          
       </div>
</div>
       
      </div>
    </div>
        
    <div class="pinned-colelem" id="u1213"><!-- simple frame --></div>
   </div>
  </div>
</asp:Content>

