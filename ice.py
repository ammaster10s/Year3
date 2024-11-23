import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from scipy.stats import kurtosis

# ชื่อไฟล์มึง
filepath = ..


data =pd.read_excel(filepath)

product_sold =data['Number of product sold']
costs = data['Costs']

# Calculate kurtosis
kurt_product_sold = kurtosis(product_sold)
kurt_costs = kurtosis(costs)

# Plotting
plt.figure(figsize=(10, 5))

# Plot for product sold
plt.subplot(1, 2, 1)
sns.histplot(product_sold, kde=True)
plt.title(f'Product Sold\nKurtosis: {kurt_product_sold:.2f}')

# Plot for costs
plt.subplot(1, 2, 2)
sns.histplot(costs, kde=True)
plt.title(f'Costs\nKurtosis: {kurt_costs:.2f}')

plt.tight_layout()
plt.show()