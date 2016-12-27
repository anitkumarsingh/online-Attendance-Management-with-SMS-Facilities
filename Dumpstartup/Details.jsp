 
<%
    String [] word={"Zero","One","Two","Three","Four","Five","Six","Seven","Eight","Nine"};
%>
<h3>DataBase Information</h3>
<div align="justify" style="border-bottom:1px dotted #C5CBCC; border-top:1px dotted #C5CBCC; padding-top:10px; padding-bottom: 10px; margin-bottom:5px;">
     <table width="100%" >
         <tr>
             <th>College Name</th>
             <td><input type="text" id="college"/></td>                   
             <th>Department</th>
             <td><input type="text" id="dept"/></td>   
         </tr>
         <tr>
             <th>Course Duration</th>
             <td>
                  <select id="course">
                     <%for(int i=1;i<10;i++){%>
                        <option value="<%=i%>" <%=i==4?"selected":""%>><%=word[i]%></option>
                     <%}%>
                 </select>
             </td>                   
             <th>Maximum No. Of Sections</th>
             <td>
                 <select id="section">
                     <%for(int i=1;i<10;i++){%>
                     <option value="<%=i%>" <%=i==2?"selected":""%>><%=word[i]%></option>
                     <%}%>
                 </select>
             </td>   
         </tr>
         <tr>
             <th>Maximum No. Of Units</th>
             <td>
                 <select id="unit">
                     <%for(int i=1;i<10;i++){%>
                     <option value="<%=i%>" <%=i==5?"selected":""%>><%=word[i]%></option>
                     <%}%>
                 </select>
             </td>                   
             <th>Maximum No. Of Periods</th>
             <td>
                 <select id="period">
                     <%for(int i=1;i<10;i++){%>
                     <option value="<%=i%>" <%=i==8?"selected":""%>><%=word[i]%></option>
                     <%}%>
                 </select>
             </td>   
         </tr>
         <tr>
             <th>Setup Year</th>
             <td>
                 <%int year = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);%>
                 <select id="year">
                     <%for(int i=0;i<10;i++){%>
                     <option value="<%=year-i%>"><%=year-i%></option>
                     <%}%>
                 </select>
             </td>                   
             <th>Semester</th>
             <td>
                 <select id="semester">
                     <option value="odd">ODD Semester</option>
                     <option value="even">EVEN Semester</option>
                 </select>
             </td>   
         </tr>
         <tr>
             
                           
             <th>Alias</th>
             <td>
                 <input type="text" id="alias"/>
             </td>  
             <td></td><td></td>
         </tr>
         <tr>
             <th valign="top">MySQL User Name & Password</th>
             <td>
                 <input type="text" id="username"/><br/>
                 <input type="password" id="password"/>
             </td>  
             <th valign="top"> Root User Name & Password</th>
             <td>
                 <input type="text" id="adminusername"/><br/>
                 <input type="password" id="adminpassword"/>
             </td>  
         </tr>
     </table>
     <p align="center"><input type="button" value="Save" onclick="save()"/></p>
</div>