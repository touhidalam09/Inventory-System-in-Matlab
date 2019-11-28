clc;
rng(0);
m = input('Enter maximum stock level: ');
n = input('Enter review period: ');
begining_inventory = 3;
ending_inventory = 3;
order_amount = 8;
lead_time = 2;
shortage_quantity = 0;
end_inv_array = [];

for cycle=1:3
   fprintf('Cycle: %d',cycle);
   for day=1:5
       fprintf('\n');
           random_demand = randi(100);
           arrives_order = lead_time - day;
           if arrives_order == -1 
              arrives_order = 0;
              begining_inventory = ending_inventory + order_amount;
           end
           if arrives_order < 0
              arrives_order = 0;
           end

           if random_demand >= 1 && random_demand <=10
               demand = 0;
           elseif random_demand >= 11 && random_demand <=35
               demand = 1;
           elseif random_demand >= 36 && random_demand <=70
               demand = 2;
           elseif random_demand >= 71 && random_demand <=91
               demand = 3;
           elseif random_demand >= 92 && random_demand <=100
               demand = 4;
           else
               demand = 4;
           end
           
           newShort = demand + shortage_quantity;
           ending_inventory = begining_inventory -  newShort;
           
           

           
           if demand > begining_inventory
               ending_inventory = 0;
               newShort = demand - begining_inventory;
               shortage_quantity = shortage_quantity + newShort;
           else
               if ending_inventory < 0 
                   shortage_quantity = abs(ending_inventory);
                   ending_inventory = 0;
               else
                   shortage_quantity = 0;
               end
           end


           if day==5
              order_quantity = m - ending_inventory;

              random_lead_time = randi(10);
              
              if random_lead_time >= 1 && random_lead_time <=6
                lead_time = 1;
              elseif random_lead_time >= 7 && random_lead_time <=9
                lead_time = 2;
              else
                lead_time = 3;
              end
              arrives_order = lead_time;
              order_amount = order_quantity;

           else
               order_quantity = 0;
               random_lead_time = 0;
           end
           
           %display
           fprintf('Day: %d',day);
           fprintf('\nBegining Inventory: %d',begining_inventory);
           fprintf('\nRabdom Digits for Demand: %d',random_demand);
           fprintf('\nDemand: %d',demand);
           fprintf('\nEnding inventory: %d',ending_inventory);
           fprintf('\nShortage Quantity: %d',shortage_quantity);
           fprintf('\nOrder Quantity: %d',order_quantity);
           fprintf('\nRandom Digits for Lead Time: %d',random_lead_time);
           fprintf('\nDays untill Order Arrives: %d',arrives_order);
           fprintf('\n\n');

           if lead_time < 0
               begining_inventory = begining_inventory+order_amount;
           else
                begining_inventory = ending_inventory;
           end    
           end_inv_array = [end_inv_array, ending_inventory];
   end
   
   fprintf('\n\n\n');
   
end
len = size(end_inv_array);
d = 1:1:15;
bar(d,end_inv_array);
title('Inventory System');
xlabel('Day');
ylabel('Ending Inventory');