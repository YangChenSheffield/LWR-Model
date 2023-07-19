function htext_y = Arrow_Ylabel(ha,str,pos,Attribute_Set)
% htext_y = Arrow_Ylabel(ha,str,pos,Attribute_Set)
% 设置箭头坐标轴图形的X轴文本标注
% ha              坐标轴(axes)句柄，默认为当前坐标轴句柄
% str             字符串
% pos             箭头坐标轴位置方向,默认为'pp',取值见plot_with_arrow
% Attribute_Set   标注文本属性设置，Textbox的属性均可以设置
%                 应为两列元胞数组，一列为属性名，另一列为属性值
% htext_y         标注文本的句柄，也可通过这个句柄设置文本属性 
% By ZFS@wust 2012.04.21
% See Also: Arrow_XY, Arrow_Xlabel, plot_with_arrow， saturate
% 获取更多Matlab/Simulink原创资料和程序，清关注微信公众号：Matlab Fans


% 给出默认值
if nargin < 4 
    Attribute_Set = [];
end
if nargin < 3 || isempty(pos)
    pos = 'pp';
end
if isempty(ha)   % 默认为当前坐标轴
    ha = gca;
end


% 求文本框应该放置的位置
rec = get( ha,'position' );                  % 坐标轴位置

if isnumeric(pos)
      [X0 Y0 Xi Yi X_y Y_x] =  deal( pos(1),pos(2),...
      pos(3),pos(4),pos(5),pos(6)  );         % 直接输入的箭头的起始位置
      pos = '';                               % pos置为字符串指示格式，方便下面的调用
      if Xi - X0 < 0 
          pos(1) = 'n';
      else
          pos(1) = 'p';
      end
      if Yi - Y0 < 0 
          pos(2) = 'n';
      else
          pos(2) = 'p';
      end
else
      [X0 Y0 Xi Yi X_y Y_x] = Arrow_XY(rec,pos);   % 箭头坐标轴位置
end

if strcmp( pos(1),'n' )          % X反向
    txi = X_y - 0.02;
    tx0 = txi - 0.2;
else                             % X正向
    tx0 = X_y + 0.025;
    txi = tx0 + 0.2;
end
if strcmp( pos(2),'n' )           % Y反向
    ty = Yi + 0.01 ;
else                              % Y正向
    ty = Yi - 0.05 ;
end

text_pos = [tx0 ty txi-tx0 0.1];
text_pos = saturate(text_pos,1,0);


% 生成文本框，并设置基本属性
hf = get(ha,'parent');      % 获取坐标轴的图形句柄
htext_y = annotation(hf,'textbox',text_pos);
color = get(hf,'color');    % 获取figure背景颜色
set(htext_y,'String',str,'EdgeColor',color,'VerticalAlignment','bottom','FitBoxToText','on','Margin',0); 
                            % 边框颜色为figure背景颜色，下对齐,自动调整矩形框以适合文字，矩形框空余为0
if strcmp( pos(1),'n' )     % 根据x轴方向设置左右对齐方式
    set(htext_y,'HorizontalAlignment','right');
    % 右对齐时，在自动调整矩形框后，需要校正文本框位置
    text_pos_get = get(htext_y,'position');
    text_pos_set = text_pos_get;
    text_pos_set(1) = text_pos_get(1) + txi - ( text_pos_get(1)+text_pos_get(3) );
    set(htext_y,'position',text_pos_set)
else
    set(htext_y,'HorizontalAlignment','left');
end
                            
% 设置附加属性
if ~isempty(Attribute_Set)
  [m n] = size(Attribute_Set);    % m为需要设置的属性数目，n必须为2                        
  if m == 2 && n == 1
           set( htext_y,Attribute_Set{ii,1},Attribute_Set{ii,2} );
  elseif n ~= 2
      error('Attribute_Set must be Two-Row Cell Matrix！');
  else
      for ii = 1:m
           set( htext_y,Attribute_Set{ii,1},Attribute_Set{ii,2} ); 
      end
  end
end

