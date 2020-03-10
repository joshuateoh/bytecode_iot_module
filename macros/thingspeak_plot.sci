function thingspeak_plot(xtime,ydata,linespec)
//    Plot a ThingSpeak field
//    
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/
//
// Syntax
//     thingspeak_plot(xtime,ydata)
//     thingspeak_plot(xtime,ydata,linespec)
//
// Parameters
//     xtime : The field's time parameter
//     ydata : The field's values
//     linespec : Options to draw the graph 
//
// Description
//    Plots a graph of a ThingSpeak field using the output from thingspeak_fieldvalues
//
// Examples
//    fv = thingspeak_fieldvalues(channelID,'private','','readkey',1,'results',100)
//    thingspeak_plot(fv.time,fv.values,'g-*')
//
// See also
//     thingspeak_channelinfo
//     thingspeak_fieldvalues
//     thingspeak_newentry
//     thingspeak_update
//
// Authors
//     Joshua T., Bytecode

    jimport java.text.SimpleDateFormat

    // Remove blank entries
    ydata1 = ydata(isnum(ydata))
    xtime1 = xtime(isnum(ydata))
    
    // Convert to numerical 
    yreal = evstr(ydata1)
    
    // Convert to datenum values
    oldformat = SimpleDateFormat.new("yyyy-MM-dd''T''HH:mm:ss''Z''")
    newformat = SimpleDateFormat.new("yyyy.MM.dd.HH.mm.ss")
    xr = size(xtime1,1)
    for i = 1:xr
    tempdate = oldformat.parse(xtime1(i));
    datestr = newformat.format(tempdate);
    datestrsplit = evstr(strsplit(datestr,"."));
    xtime2(i) = datenum(datestrsplit(1),datestrsplit(2),datestrsplit(3),datestrsplit(4),datestrsplit(5),datestrsplit(6))
end
    
    rhs=argn(2);
    if rhs == 2 then
        scf();
        plot(xtime2,yreal)
    elseif rhs == 3
        scf();
        plot(xtime2,yreal,linespec);
    else
        error(msprintf("Wrong number of inputs. 2-3 arguments expected.\n"))
    end
    // Change x labels to dates
    myaxis = gca();
    xtick=evstr(strsubst(myaxis.x_ticks.labels," ",""));
    tr=size(xtick,1);
    tlabels=[];
    
    for i=1:tr
        datearr=datevec(xtick(i,1))
        s1=msprintf("%d-%02d-%02d",datearr(1),datearr(2),datearr(3)); 
        s2=msprintf("%02d:%02d:%02d",datearr(4),datearr(5),datearr(6));    
        strlatex="$ {\begin{matrix}\textbf{"+s1+"}\\ \textbf{"+s2+"}\end{matrix}} $";
        tlabels=[tlabels;strlatex];
    end
    myaxis.x_ticks.labels=tlabels;
    
endfunction
