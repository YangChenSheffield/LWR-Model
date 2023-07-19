function set_handle(h,name,value)

switch name
    case 'width'
       pos = get(h,'position');
       pos(3) = pos(1) + value;
       set(h,'position',pos);
    case 'hight'
       pos = get(h,'position');
       pos(4) = pos(2) + value;
       set(h,'position',pos);
end