<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="about.aspx.cs" Inherits="Default4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>

        #page_position_content{
            margin-left:0px;
        }

.sidecatmenu{
    margin-left: 85px;
}
        input/**********Admin input style(also used in icon,text fields,buttons)***********/
{
	margin: 0;
	padding: 0;
	border-width: 1px;/*******turn it off to show border. looks good in buttons(view all comment etc.). bad in search box, right-side tabs*******/
	-webkit-transform-origin: left top;
	-ms-transform-origin: left top;
	-o-transform-origin: left top;
	transform-origin: left top;
    border: 1px dotted #808080;
    font-family: inherit;
	font-size: inherit;
	font-style: inherit;
	font-weight: inherit;
    border-radius: 3px; 
    -moz-border-radius: 3px; 
    -webkit-border-radius: 3px; 
}
        .input:focus { 
    outline: none; 
    border: 1px solid #7bc1f7;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px; 
    box-shadow: 0px 0px 8px #7bc1f7; 
    -moz-box-shadow: 0px 0px 8px #7bc1f7; 
    -webkit-box-shadow: 0px 0px 8px #7bc1f7; 
}

input:hover {
    border-radius: 3px; 
    -moz-border-radius: 3px; 
    -webkit-border-radius: 3px; 
    box-shadow: 0px 0px 8px #d9d9d9; 
    -moz-box-shadow: 0px 0px 8px #d9d9d9; 
    -webkit-box-shadow: 0px 0px 8px #d9d9d9;
}
        #top_menu {
            display: none;
        }

        #page {
            background-color: white;
        }
        .hideextra{
            color:#5b5959;
        }

        a:link/****************on click fucntion*****************/
{
	color: black;
    font-weight:normal;
	text-decoration: none;
}

        a:active/****************on click fucntion*****************/
{
	font-weight:normal;
	text-decoration: none;
}
.ajax__tab_tab{
    background-color:#26284f !important;
    height:auto !important;
    width:100px !important;
    color: white !important;
    font-size:10px !important;
}
.ajax__tab{
    background-color:red  !important;

}

.ajax__tab_xp .ajax__tab_header_verticalleft .ajax__tab_tab{

    background:none !important;
    background-color:#326ead!important;
}
.ajax__tab_xp .ajax__tab_body_verticalleft{
    border:0px !important;
}

.ajax__tab_outer{
     background:none !important;
     height:auto !important;
}

.ajax__tab_inner{
     background:none !important;
     padding:0px !important;
}

    </style>
    <style>
.hideextra { white-space: nowrap; overflow: hidden; text-overflow:ellipsis; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_top_menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_left_menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server" >
    <div style="margin-top: 114px;background-color: rgb(255, 255, 255);padding-top: 30px;padding-left: 15px;clear: both;">
        <ajaxToolkit:TabContainer runat="server" ActiveTabIndex="0" UseVerticalStripPlacement="true" style="
    margin-left: 0px;
    width: 945px;
">
            <ajaxToolkit:TabPanel runat="server" HeaderText="Basic Information"  ID="TabGeneral">
               
                <ContentTemplate>
                   
                    <%--<asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="300px" AutoGenerateRows="False" DataSourceID="ProfileDS" BorderWidth="0px">
                        <Fields>
                         
                             <asp:BoundField DataField="FullName" HeaderText="FullName" SortExpression="FullName" />
                            <asp:BoundField DataField="Age" HeaderText="Age" SortExpression="Age" />
                            <asp:BoundField DataField="Birthday" HeaderText="Birthday" SortExpression="Birthday" />
                            <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                            <asp:BoundField DataField="Interested" HeaderText="Interested" SortExpression="Interested" />
                            <asp:BoundField DataField="Language" HeaderText="Language" SortExpression="Language" />
                            <asp:BoundField DataField="RelView" HeaderText="RelView" SortExpression="RelView" />
                            <asp:BoundField DataField="PolView" HeaderText="PolView" SortExpression="PolView" />
                            <asp:BoundField DataField="Aboutme" HeaderText="Aboutme" SortExpression="Aboutme" />
                             <asp:BoundField DataField="Quote" HeaderText="Quote" SortExpression="Quote" />
                        </Fields>
                        
                    </asp:DetailsView>--%>
                    <asp:ListView ID="ListView1" runat="server" DataSourceID="ProfileDS" OnItemUpdating="ListView1_ItemUpdating" OnItemDataBound="ListView1_ItemDataBound">
                       
                        <EditItemTemplate>
                            <span style="">
                                <table style="width: 100%">
                    <tr>
                        <td class="hideextra">Full Name:</td>
                        <td>
                            <asp:TextBox ID="FullNameTextBox" runat="server" Text='<%# Bind("FullName") %>' />
                        </td>

                    </tr>
                   <%-- <tr>
                        <td class="hideextra">Age:</td>
                        <td>
                            <asp:TextBox ID="AgeTextBox" runat="server" Text='<%# Bind("Age") %>' />

                        </td>

                    </tr>--%>
                      <tr>
                        <td class="hideextra">Birthday:</td>
                        <td>
                          <%--  <asp:TextBox ID="BirthdayTextBox" runat="server" Text='<%# Bind("Birthday") %>' />--%>
                            <asp:DropDownList ID="Day" runat="server" CssClass="sma2" ToolTip="Day" DataTextField='<%# Bind("Day") %>' DataValueField='<%# Bind("Day") %>'>
                                <asp:ListItem>Day</asp:ListItem>
                                <asp:ListItem>1</asp:ListItem>
                                <asp:ListItem>2</asp:ListItem>
                                <asp:ListItem>3</asp:ListItem>
                                <asp:ListItem>4</asp:ListItem>
                                <asp:ListItem>5</asp:ListItem>
                                <asp:ListItem>6</asp:ListItem>
                                <asp:ListItem>7</asp:ListItem>
                                <asp:ListItem>8</asp:ListItem>
                                <asp:ListItem>9</asp:ListItem>
                                <asp:ListItem>10</asp:ListItem>
                                <asp:ListItem>11</asp:ListItem>
                                <asp:ListItem>12</asp:ListItem>
                                <asp:ListItem>13</asp:ListItem>
                                <asp:ListItem>14</asp:ListItem>
                                <asp:ListItem>15</asp:ListItem>
                                <asp:ListItem>16</asp:ListItem>
                                <asp:ListItem>17</asp:ListItem>
                                <asp:ListItem>18</asp:ListItem>
                                <asp:ListItem>19</asp:ListItem>
                                <asp:ListItem>20</asp:ListItem>
                                <asp:ListItem>21</asp:ListItem>
                                <asp:ListItem>22</asp:ListItem>
                                <asp:ListItem>23</asp:ListItem>
                                <asp:ListItem>24</asp:ListItem>
                                <asp:ListItem>25</asp:ListItem>
                                <asp:ListItem>26</asp:ListItem>
                                <asp:ListItem>27</asp:ListItem>
                                <asp:ListItem>28</asp:ListItem>
                                <asp:ListItem>29</asp:ListItem>
                                <asp:ListItem>30</asp:ListItem>
                                <asp:ListItem>31</asp:ListItem>
                                    </asp:DropDownList>
                            <asp:DropDownList ID="Month" runat="server" CssClass="sma2" ToolTip="Month" DataTextField='<%# Bind("Month") %>' DataValueField='<%# Bind("Month") %>'>
                                <asp:ListItem>Month</asp:ListItem>
                                <asp:ListItem>Jan</asp:ListItem>
                                <asp:ListItem>Feb</asp:ListItem>
                                <asp:ListItem>Mar</asp:ListItem>
                                <asp:ListItem>Apr</asp:ListItem>
                                <asp:ListItem>May</asp:ListItem>
                                <asp:ListItem>Jun</asp:ListItem>
                                <asp:ListItem>Jul</asp:ListItem>
                                <asp:ListItem>Aug</asp:ListItem>
                                <asp:ListItem>Sep</asp:ListItem>
                                <asp:ListItem>Oct</asp:ListItem>
                                <asp:ListItem>Nov</asp:ListItem>
                                <asp:ListItem>Dec</asp:ListItem>
                                    </asp:DropDownList>
                            <asp:DropDownList ID="Year" runat="server" CssClass="sma2" ToolTip="Year" DataTextField='<%# Bind("Year") %>' DataValueField='<%# Bind("Year") %>'>
                                <asp:ListItem>Year</asp:ListItem>
                                <asp:ListItem>2014</asp:ListItem>
                                <asp:ListItem>2013</asp:ListItem>
                                <asp:ListItem>2012</asp:ListItem>
                                <asp:ListItem>2011</asp:ListItem>
                                <asp:ListItem>2010</asp:ListItem>
                                <asp:ListItem>2009</asp:ListItem><asp:ListItem>2008</asp:ListItem><asp:ListItem>2007</asp:ListItem><asp:ListItem>2006</asp:ListItem><asp:ListItem>2005</asp:ListItem><asp:ListItem>2004</asp:ListItem><asp:ListItem>2003</asp:ListItem><asp:ListItem>2002</asp:ListItem><asp:ListItem>2001</asp:ListItem><asp:ListItem>2000</asp:ListItem><asp:ListItem>1999</asp:ListItem><asp:ListItem>1998</asp:ListItem><asp:ListItem>1997</asp:ListItem><asp:ListItem>1996</asp:ListItem><asp:ListItem>1995</asp:ListItem><asp:ListItem>1994</asp:ListItem><asp:ListItem>1993</asp:ListItem><asp:ListItem>1992</asp:ListItem><asp:ListItem>1991</asp:ListItem><asp:ListItem>1990</asp:ListItem><asp:ListItem>1989</asp:ListItem><asp:ListItem>1988</asp:ListItem><asp:ListItem>1987</asp:ListItem><asp:ListItem>1986</asp:ListItem><asp:ListItem>1985</asp:ListItem><asp:ListItem>1984</asp:ListItem><asp:ListItem>1983</asp:ListItem><asp:ListItem>1982</asp:ListItem><asp:ListItem>1981</asp:ListItem><asp:ListItem>1980</asp:ListItem><asp:ListItem>1979</asp:ListItem><asp:ListItem>1978</asp:ListItem><asp:ListItem>1977</asp:ListItem><asp:ListItem>1976</asp:ListItem><asp:ListItem>1975</asp:ListItem><asp:ListItem>1974</asp:ListItem><asp:ListItem>1973</asp:ListItem><asp:ListItem>1972</asp:ListItem><asp:ListItem>1971</asp:ListItem><asp:ListItem>1970</asp:ListItem><asp:ListItem>1969</asp:ListItem><asp:ListItem>1968</asp:ListItem><asp:ListItem>1967</asp:ListItem><asp:ListItem>1966</asp:ListItem><asp:ListItem>1965</asp:ListItem><asp:ListItem>1964</asp:ListItem><asp:ListItem>1963</asp:ListItem><asp:ListItem>1962</asp:ListItem><asp:ListItem>1961</asp:ListItem><asp:ListItem>1960</asp:ListItem><asp:ListItem>1959</asp:ListItem><asp:ListItem>1958</asp:ListItem><asp:ListItem>1957</asp:ListItem><asp:ListItem>1956</asp:ListItem><asp:ListItem>1955</asp:ListItem><asp:ListItem>1954</asp:ListItem><asp:ListItem>1953</asp:ListItem><asp:ListItem>1952</asp:ListItem><asp:ListItem>1951</asp:ListItem><asp:ListItem>1950</asp:ListItem><asp:ListItem>1949</asp:ListItem><asp:ListItem>1948</asp:ListItem><asp:ListItem>1947</asp:ListItem><asp:ListItem>1946</asp:ListItem><asp:ListItem>1945</asp:ListItem><asp:ListItem>1944</asp:ListItem><asp:ListItem>1943</asp:ListItem><asp:ListItem>1942</asp:ListItem><asp:ListItem>1941</asp:ListItem><asp:ListItem>1940</asp:ListItem><asp:ListItem>1939</asp:ListItem><asp:ListItem>1938</asp:ListItem><asp:ListItem>1937</asp:ListItem><asp:ListItem>1936</asp:ListItem><asp:ListItem>1935</asp:ListItem><asp:ListItem>1934</asp:ListItem><asp:ListItem>1933</asp:ListItem><asp:ListItem>1932</asp:ListItem><asp:ListItem>1931</asp:ListItem><asp:ListItem>1930</asp:ListItem><asp:ListItem>1929</asp:ListItem><asp:ListItem>1928</asp:ListItem><asp:ListItem>1927</asp:ListItem><asp:ListItem>1926</asp:ListItem><asp:ListItem>1925</asp:ListItem><asp:ListItem>1924</asp:ListItem><asp:ListItem>1923</asp:ListItem><asp:ListItem>1922</asp:ListItem><asp:ListItem>1921</asp:ListItem><asp:ListItem>1920</asp:ListItem><asp:ListItem>1919</asp:ListItem><asp:ListItem>1918</asp:ListItem><asp:ListItem>1917</asp:ListItem><asp:ListItem>1916</asp:ListItem><asp:ListItem>1915</asp:ListItem><asp:ListItem>1914</asp:ListItem><asp:ListItem>1913</asp:ListItem><asp:ListItem>1912</asp:ListItem><asp:ListItem>1911</asp:ListItem><asp:ListItem>1910</asp:ListItem><asp:ListItem>1909</asp:ListItem><asp:ListItem>1908</asp:ListItem><asp:ListItem>1907</asp:ListItem><asp:ListItem>1906</asp:ListItem><asp:ListItem>1905</asp:ListItem> 
                            </asp:DropDownList>

                        </td>

                    </tr>
                      <tr>
                        <td class="hideextra">Gender:</td>
                        <td>
                            <asp:DropDownList ID="GenderTextBox" runat="server">
                                    <asp:ListItem Text="Male">                                    
                                    </asp:ListItem>
                                         <asp:ListItem Text="Female"></asp:ListItem>
                                </asp:DropDownList>

                        </td>

                    </tr>
                     <tr>
                        <td class="hideextra">Interested In:</td>
                        <td>
                          
                            <asp:CheckBoxList ID="InterestedCheckBox" runat="server">
                                <asp:ListItem Text="Male"></asp:ListItem>
                                    <asp:ListItem Text="Female"></asp:ListItem>
                            </asp:CheckBoxList>

                        </td>

                    </tr>
                                      <tr>
                        <td class="hideextra">Relationship Status:</td>
                        <td>
                            <asp:DropDownList ID="ddlRelationship" runat="server">
                                <asp:ListItem Text="Single"></asp:ListItem>
                                 <asp:ListItem Text="In a relationship"></asp:ListItem>
                                 <asp:ListItem Text="Engaged"></asp:ListItem>
                                 <asp:ListItem Text="Married"></asp:ListItem>
                                 <asp:ListItem Text="In an open relationship"></asp:ListItem>
                                 <asp:ListItem Text="It's complicated"></asp:ListItem>
                                 <asp:ListItem Text="Separated"></asp:ListItem>
                                <asp:ListItem Text="Divorced"></asp:ListItem>
                                <asp:ListItem Text="Widowed"></asp:ListItem>
                            </asp:DropDownList>

                        </td>

                    </tr>
                     <tr>
                        <td class="hideextra">Language:</td>
                        <td>
                            <asp:TextBox ID="LanguageTextBox" runat="server" Text='<%# Bind("Language") %>' />

                        </td>

                    </tr>
                     <tr>
                        <td class="hideextra">Religious View:</td>
                        <td>
                            <asp:TextBox ID="RelViewTextBox" runat="server" Text='<%# Bind("RelView") %>' />

                        </td>

                    </tr>
                                     <tr>
                        <td class="hideextra">Political View:</td>
                        <td>
                            <asp:TextBox ID="PolViewTextBox" runat="server" Text='<%# Bind("PolView") %>' />

                        </td>

                    </tr>
                                     <tr>
                        <td class="hideextra">About Me:</td>
                        <td>
                            <asp:TextBox ID="AboutmeTextBox" runat="server" Text='<%# Bind("Aboutme") %>' />

                        </td>

                    </tr>
                                          <tr>
                        <td class="hideextra">Quote:</td>
                        <td>
                            <asp:TextBox ID="QuoteTextBox" runat="server" Text='<%# Bind("Quote") %>' />

                        </td>

                    </tr>

                </table>
                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
                            <br />
                            <br />
                            </span>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <span>No data was returned.</span>
                        </EmptyDataTemplate>
                        <InsertItemTemplate>
                            <span style="">Full Name:
                            <asp:TextBox ID="FullNameTextBox" runat="server" Text='<%# Bind("FullName") %>' />
                            <br />
                            Age:
                            <asp:TextBox ID="AgeTextBox" runat="server" Text='<%# Bind("Age") %>' />
                            <br />
                            Birthday:
                            <asp:TextBox ID="BirthdayTextBox" runat="server" Text='<%# Bind("Birthday") %>' />
                            <br />
                            Gender:
                            <asp:TextBox ID="GenderTextBox" runat="server" Text='<%# Bind("Gender") %>' />
                            <br />
                            Interested:
                            <asp:TextBox ID="InterestedTextBox" runat="server" Text='<%# Bind("Interested") %>' />
                            <br />
                            Language:
                            <asp:TextBox ID="LanguageTextBox" runat="server" Text='<%# Bind("Language") %>' />
                            <br />
                            RelView:
                            <asp:TextBox ID="RelViewTextBox" runat="server" Text='<%# Bind("RelView") %>' />
                            <br />
                            PolView:
                            <asp:TextBox ID="PolViewTextBox" runat="server" Text='<%# Bind("PolView") %>' />
                            <br />
                            Aboutme:
                            <asp:TextBox ID="AboutmeTextBox" runat="server" Text='<%# Bind("Aboutme") %>' />
                            <br />
                            Quote:
                            <asp:TextBox ID="QuoteTextBox" runat="server" Text='<%# Bind("Quote") %>' />
                            <br />
                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                            <br />
                            <br />
                            </span>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <span style="">
                                <table style="width: 100%">
                    <tr>
                        <td class="hideextra">Full Name:</td>
                        <td>
                            <asp:Label ID="FullNameLabel" runat="server" Text='<%# Eval("FullName") %>' />
                        </td>
                       
                    </tr>
                                    
       <%--             <tr>
                        <td class="hideextra">Age:</td>
                        <td>
                            <asp:Label ID="AgeLabel" runat="server" Text='<%# Eval("Age") %>' />

                        </td>

                    </tr>--%>
                      <tr>
                        <td class="hideextra">Birthday:</td>
                        <td>
                            <asp:Label ID="DayLabel" runat="server" Text='<%# Eval("Day") %>' /> /
                             <asp:Label ID="MonthLabel" runat="server" Text='<%# Eval("Month") %>' /> /
                             <asp:Label ID="YearLabel" runat="server" Text='<%# Eval("Year") %>' />

                        </td>

                    </tr>
                      <tr>
                        <td class="hideextra">Gender:</td>
                        <td>
                            <asp:Label ID="GenderLabel" runat="server" Text='<%# Eval("Gender") %>' />

                        </td>

                    </tr>
                     <tr>
                        <td class="hideextra">Interested In:</td>
                        <td>
                            <asp:Label ID="InterestedLabel" runat="server" Text='<%# Eval("Interested") %>' />

                        </td>

                    </tr>
                                      <tr>
                        <td class="hideextra">Relationship Status:</td>
                        <td>
                            <asp:Label ID="RelationshipLabel" runat="server" Text='<%# Eval("Relationship") %>' />

                        </td>

                    </tr>
                     <tr>
                        <td class="hideextra">Language:</td>
                        <td>
                            <asp:Label ID="LanguageLabel" runat="server" Text='<%# Eval("Language") %>' />

                        </td>

                    </tr>
                     <tr>
                        <td class="hideextra">Religious View:</td>
                        <td>
                            <asp:Label ID="RelViewLabel" runat="server" Text='<%# Eval("RelView") %>' />

                        </td>

                    </tr>
                                     <tr>
                        <td class="hideextra">Political View:</td>
                        <td>
                            <asp:Label ID="PolViewLabel" runat="server" Text='<%# Eval("PolView") %>' />

                        </td>

                    </tr>
                                     <tr>
                        <td class="hideextra">About Me:</td>
                        <td>
                            <asp:Label ID="AboutmeLabel" runat="server" Text='<%# Eval("Aboutme") %>' />

                        </td>

                    </tr>
                                          <tr>
                        <td class="hideextra">Quote:</td>
                        <td>
                            <asp:Label ID="QuoteLabel" runat="server" Text='<%# Eval("Quote") %>' />

                        </td>

                    </tr>

                </table>
                          
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
                            <br />
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
                            <span style="">Full Name:
                            <asp:Label ID="FullNameLabel" runat="server" Text='<%# Eval("FullName") %>' />
                            <br />
                            Age:
                            <asp:Label ID="AgeLabel" runat="server" Text='<%# Eval("Age") %>' />
                            <br />
                            Birthday:
                            <asp:Label ID="BirthdayLabel" runat="server" Text='<%# Eval("Birthday") %>' />
                            <br />
                            Gender:
                            <asp:Label ID="GenderLabel" runat="server" Text='<%# Eval("Gender") %>' />
                            <br />
                            Interested:
                            <asp:Label ID="InterestedLabel" runat="server" Text='<%# Eval("Interested") %>' />
                            <br />
                            Language:
                            <asp:Label ID="LanguageLabel" runat="server" Text='<%# Eval("Language") %>' />
                            <br />
                            RelView:
                            <asp:Label ID="RelViewLabel" runat="server" Text='<%# Eval("RelView") %>' />
                            <br />
                            PolView:
                            <asp:Label ID="PolViewLabel" runat="server" Text='<%# Eval("PolView") %>' />
                            <br />
                            Aboutme:
                            <asp:Label ID="AboutmeLabel" runat="server" Text='<%# Eval("Aboutme") %>' />
                            <br />
                            Quote:
                            <asp:Label ID="QuoteLabel" runat="server" Text='<%# Eval("Quote") %>' />
                            <br />
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
                            <br />
                            <br />
                            </span>
                        </SelectedItemTemplate>
                    </asp:ListView>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
           
            <ajaxToolkit:TabPanel ID="TabPrivacy" runat="server" HeaderText="Work/Education">
                <HeaderTemplate>
                    Work/Education
                </HeaderTemplate>
                <ContentTemplate>
                   <asp:ListView ID="ListView2" OnItemDataBound="ListView2_ItemDataBound" runat="server" DataKeyNames="UserId" DataSourceID="WorkEducationDS">
          
         <EditItemTemplate>
            <span>
                <table style="width: 100%">
                    <tr>
                        <td class="hideextra">University:</td>
                        <td>
                            <asp:TextBox ID="UniversityTextBox" runat="server" Text='<%# Bind("University") %>' />
                        </td>

                    </tr>
                    <tr>
                        <td class="hideextra">High School:</td>
                        <td>
                            <asp:TextBox ID="School_CollegeTextBox" runat="server" Text='<%# Bind("School_College") %>' />

                        </td>

                    </tr>
                      <tr>
                        <td class="hideextra"> Skills:</td>
                        <td>
            <asp:TextBox ID="SkillsTextBox" runat="server" Text='<%# Bind("Skills") %>' />

                        </td>

                    </tr>
                      <tr>
                        <td class="hideextra">Career:
</td>
                        <td>
            <asp:TextBox ID="CareerTextBox" runat="server" Text='<%# Bind("Career") %>' />

                        </td>

                    </tr>
                     <tr>
                        <td class="hideextra">Career Description:
</td>
                        <td>
            <asp:TextBox ID="CareerDescriptionTextBox" runat="server" Text='<%# Bind("CareerDescription") %>' />

                        </td>

                    </tr>

                </table>

               
          
            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
            <br /><br /></span>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <span>No data was returned.</span>
        </EmptyDataTemplate>
        
        <ItemTemplate>
            <span style="">
           
                <table style="width: 100%">
                    <tr>
                        <td class="hideextra">University:</td>
                        <td>
                            <asp:Label ID="UniversityLabel" runat="server" Text='<%# Eval("University") %>' />
                        </td>

                    </tr>
                    <tr>
                        <td class="hideextra">High School:</td>
                        <td>
                            <asp:Label ID="School_CollegeLabel" runat="server" Text='<%# Eval("School_College") %>' />

                        </td>

                    </tr>
                      <tr>
                        <td class="hideextra"> Skills:</td>
                        <td>
            <asp:Label ID="SkillsLabel" runat="server" Text='<%# Eval("Skills") %>' />

                        </td>

                    </tr>
                      <tr>
                        <td class="hideextra">Career:
</td>
                        <td>
            <asp:Label ID="CareerLabel" runat="server" Text='<%# Eval("Career") %>' />

                        </td>

                    </tr>
                     <tr>
                        <td class="hideextra">Career Description:
</td>
                        <td>
            <asp:Label ID="CareerDescriptionLabel" runat="server" Text='<%# Eval("CareerDescription") %>' />

                        </td>

                    </tr>

                </table>
           
         
           

           
            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
<br /><br /></span>
        </ItemTemplate>
        <LayoutTemplate>
            <div id="itemPlaceholderContainer" runat="server" style="">
                <span runat="server" id="itemPlaceholder" />
            </div>
            <div style="">
            </div>
        </LayoutTemplate>
        
    </asp:ListView>
                     </ContentTemplate>
            </ajaxToolkit:TabPanel>
            <ajaxToolkit:TabPanel ID="TabSecurity" runat="server" HeaderText="Contact" Width="100">
                <ContentTemplate>
                <asp:ListView ID="ListView3" OnItemDataBound="ListView3_ItemDataBound" runat="server" DataKeyNames="UserId" DataSourceID="ContactInfoDS">
          
         <EditItemTemplate>
            <span>
             <span style="">
           
                <table style="width: 100%">
                    <tr>
                        <td class="hideextra">Private Number:</td>
                        <td>
            <asp:TextBox ID="PNumTextBox" runat="server" Text='<%# Bind("PNum") %>' />
                        </td>

                    </tr>
                    <tr>
                        <td class="hideextra">Work Number:</td>
                        <td>
            <asp:TextBox ID="WNumTextBox" runat="server" Text='<%# Bind("WNum") %>' />

                        </td>

                    </tr>
                      <tr>
                        <td class="hideextra">Country:</td>
                        <td>
            <asp:TextBox ID="CountryTextBox" runat="server" Text='<%# Bind("Country") %>' />

                        </td>

                    </tr>
                      <tr>
                        <td class="hideextra">City:</td>
                        <td>
            <asp:TextBox ID="CityTextBox" runat="server" Text='<%# Bind("City") %>' />

                        </td>

                    </tr>
                     <tr>
                        <td class="hideextra">Hometown:</td>
                        <td>
            <asp:TextBox ID="HometownTextBox" runat="server" Text='<%# Bind("Hometown") %>' />

                        </td>

                    </tr>
                     <tr>
                        <td class="hideextra">Address:</td>
                        <td>
            <asp:TextBox ID="AddressTextBox" runat="server" Text='<%# Bind("Address") %>' />

                        </td>

                    </tr>
                     <tr>
                        <td class="hideextra">E_mail:</td>
                        <td>
            <asp:TextBox ID="E_mailTextBox" runat="server" Text='<%# Bind("E_mail") %>' />

                        </td>

                    </tr>

                </table>

               
          
            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
            <br /><br /></span>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <span>No data was returned.</span>
        </EmptyDataTemplate>
        
        <ItemTemplate>
            <span style="">
           
                <table style="width: 100%">
                    <tr>
                        <td class="hideextra">Private Number:</td>
                        <td>
            <asp:Label ID="PNumLabel" runat="server" Text='<%# Eval("PNum") %>' />
                        </td>

                    </tr>
                    <tr>
                        <td class="hideextra">Work Number:</td>
                        <td>
            <asp:Label ID="WNumLabel" runat="server" Text='<%# Eval("WNum") %>' />

                        </td>

                    </tr>
                      <tr>
                        <td class="hideextra">Country:</td>
                        <td>
            <asp:Label ID="CountryLabel" runat="server" Text='<%# Eval("Country") %>' />

                        </td>

                    </tr>
                      <tr>
                        <td class="hideextra">City:</td>
                        <td>
            <asp:Label ID="CityLabel" runat="server" Text='<%# Eval("City") %>' />

                        </td>

                    </tr>
                     <tr>
                        <td class="hideextra">Hometown:</td>
                        <td>
            <asp:Label ID="HometownLabel" runat="server" Text='<%# Eval("Hometown") %>' />

                        </td>

                    </tr>
                     <tr>
                        <td class="hideextra">Address:</td>
                        <td>
            <asp:Label ID="AddressLabel" runat="server" Text='<%# Eval("Address") %>' />

                        </td>

                    </tr>
                     <tr>
                        <td class="hideextra">E_mail:</td>
                        <td>
            <asp:Label ID="E_mailLabel" runat="server" Text='<%# Eval("E_mail") %>' />

                        </td>

                    </tr>

                </table>
           
         

           
            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
<br /><br /></span>
        </ItemTemplate>
        <LayoutTemplate>
            <div id="itemPlaceholderContainer" runat="server" style="">
                <span runat="server" id="itemPlaceholder" />
            </div>
            <div style="">
            </div>
        </LayoutTemplate>
        
    </asp:ListView>
                    </ContentTemplate>
                </ajaxToolkit:TabPanel>
           
        </ajaxToolkit:TabContainer>

    
    <asp:SqlDataSource ID="ProfileDS" runat="server" OnUpdating="ProfileDS_Updating" OnSelecting="ProfileDS_Selecting" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" DeleteCommand="DELETE FROM [UserProfiles] WHERE [UserId] = @UserId" 
        SelectCommand="SELECT FullName, Age,Day,Month,Year, Birthday, Gender, Interested, Language, RelView, PolView, Aboutme, Quote, Relationship FROM UserProfiles WHERE (UserId = @UserId)" 
        UpdateCommand="UPDATE UserProfiles SET FullName = @FullName, Day=@Day,Month=@Month,Year=@Year, Gender = @Gender, Interested = @Interested, Language = @Language, RelView = @RelView, PolView = @PolView, Aboutme = @Aboutme, Quote = @Quote, Relationship = @Relationship WHERE [UserId] = @UserId ">
        <DeleteParameters>
            <asp:Parameter Name="UserId" Type="Object" />
        </DeleteParameters>
        
        
        <SelectParameters>
            <asp:Parameter Name="UserId" Type="Object" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FullName" Type="String" />
           <asp:Parameter Name="Day" Type="String" />
            <asp:Parameter Name="Month" Type="String" />
            <asp:Parameter Name="Year" Type="String" />
       <%--     <asp:Parameter Name="Birthday" Type="String" />--%>
            <asp:Parameter Name="Gender" Type="String" />
            <asp:Parameter Name="Interested" Type="String" />
            <asp:Parameter Name="Language" Type="String" />
            <asp:Parameter Name="RelView" Type="String" />
            <asp:Parameter Name="PolView" Type="String" />
            <asp:Parameter Name="Aboutme" Type="String" />
            <asp:Parameter Name="Quote" Type="String" />
           
            <asp:Parameter Name="Relationship" Type="String" />
           
          </UpdateParameters>
    </asp:SqlDataSource>
                            <asp:SqlDataSource ID="WorkEducationDS" OnUpdating="WorkEducationDS_Updating" OnSelecting="WorkEducationDS_Selecting" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT University, School_College, Skills, Career, CareerDescription, UserId FROM UserProfiles WHERE (UserId = @UserId)" 
                                UpdateCommand="UPDATE UserProfiles SET University = @University, School_College = @School_College, Skills = @Skills, Career = @Career, CareerDescription = @CareerDescription WHERE [UserId] = @UserId">
                                <SelectParameters>
                                    <asp:Parameter Name="UserId" Type="Object" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="University" />
                                    <asp:Parameter Name="College" />
                                    <asp:Parameter Name="Skills" />
                                    <asp:Parameter Name="Career" />
                                    <asp:Parameter Name="CareerDescription" />
                                    <asp:Parameter Name="School_College" />
                                </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="ContactInfoDS" OnUpdating="ContactInfoDS_Updating" OnSelecting="ContactInfoDS_Selecting" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT PNum, WNum, Country, City, Hometown, Address, E_mail, UserId FROM UserProfiles WHERE (UserId = @UserId)" UpdateCommand="UPDATE UserProfiles SET PNum = @PNum, WNum = @WNum, Country = @Country, City = @City, Hometown = @Hometown, Address = @Address, E_mail = @E_mail WHERE (UserId = @UserId)">
            <SelectParameters>
                <asp:Parameter Name="UserId" Type="Object" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="PNum" />
                <asp:Parameter Name="WNum" />
                <asp:Parameter Name="Country" />
                <asp:Parameter Name="City" />
                <asp:Parameter Name="Hometown" />
                <asp:Parameter Name="Address" />
                <asp:Parameter Name="E_mail" />
            </UpdateParameters>
        </asp:SqlDataSource>


         <div class="clearfix grpelem" id="side_menu_bar"style="top: 300px;margin-left: 750px;position: fixed;";
"><!-- column -->
        <asp:Button ID="btnPost" runat="server" Text="Post" CssClass="sidecatmenu"  />
          <asp:Button ID="btnVideo" runat="server" Text="Video" CssClass="sidecatmenu" OnClick="btnVideo_Click"  />
          <asp:Button ID="btnPhoto" runat="server" Text="Photo" CssClass="sidecatmenu" OnClick="btnPhoto_Click"  />
          <asp:Button ID="btnFriend" runat="server" Text="Friend" CssClass="sidecatmenu" OnClick="btnFriend_Click" />
          <asp:Button ID="btnAbout" runat="server" Text="About" CssClass="sidecatmenu" OnClick="btnAbout_Click"  />
          
       </div>
        </div>
    
</asp:Content>

