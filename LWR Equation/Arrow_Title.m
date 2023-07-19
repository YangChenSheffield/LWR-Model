function htext_title = Arrow_Title(ha,str,Attribute_Set)
% htext_title = Arrow_Title(ha,str,pos,Attribute_Set)
% 设置箭头坐标轴图形的标题(Title)
% ha              坐标轴(axes)句柄，默认为当前坐标轴句柄
% str             字符串
% Attribute_Set   标注文本属性设置，Textbox的属性均可以设置
%                 应为两列元胞数组，一列为属性名，另一列为属性值
% htext_title         标注文本的句柄，也可通过这个句柄设置文本属性
% By ZFS@wust 2012.04.21
% See Also: Arrow_XY, Arrow_Xlabel, Arrow_Ylabel, plot_with_arrow
% 获取更多Matlab/Simulink原创资料和程序，清关注微信公众号：Matlab Fans

% 给出默认值
if nargin < 3 
    Attribute_Set = [];
end
if isempty(ha)   % 默认为当前坐标轴
    ha = gca;
end


% 求文本框应该放置的位置
rec = get( ha,'position' );                  % 坐标轴位置
ty = rec(2) + rec(4) + 0.01;
tx0 = rec(1);
text_pos = [tx0 ty rec(3) 0.1];


% 生成文本框，并设置基本属性
hf = get(ha,'parent');      % 获取坐标轴的图形句柄
htext_title = annotation(hf,'textbox',text_pos);
color = get(hf,'color');    % 获取figure背景颜色
set(htext_title,'String',str,'EdgeColor',color,'VerticalAlignment','bottom','HorizontalAlignment','center','FitBoxToText','on','Margin',0); 
                            % 边框颜色为figure背景颜色，居中下对齐,自动调整矩形框以适合文字，矩形框空余为0

           
% 设置附加属性
if ~isempty(Attribute_Set)
  [m n] = size(Attribute_Set);    % m为需要设置的属性数目，n必须为2                        
  if m == 2 && n == 1
           set( htext_title,Attribute_Set{ii,1},Attribute_Set{ii,2} );
  elseif n ~= 2
      error('Attribute_Set must be Two-Row Cell Matrix！');
  else
      for ii = 1:m
           set( htext_title,Attribute_Set{ii,1},Attribute_Set{ii,2} ); 
      end
  end
end

