groups = [
  {
    external_id: '317723905026242',
    name: 'KL Ruby Brigade',
    url: 'https://www.facebook.com/groups/317723905026242',
    status: 'authorized'
  },
  {
    external_id: '322921234428132',
    name: 'Sinar Project',
    url: 'https://www.facebook.com/groups/322921234428132',
    status: 'authorized'
  },
  {
    external_id: '140411929363818',
    name: 'Programming Laman Web + UI/UX',
    url: 'https://www.facebook.com/groups/140411929363818',
    status: 'authorized'
  },
  {
    external_id: '408755619178957',
    name: 'UX Malaysia',
    url: 'https://www.facebook.com/groups/408755619178957',
    status: 'authorized'
  },
  {
    external_id: '129320377135968',
    name: 'MYCocoaHeads',
    url: 'https://www.facebook.com/groups/129320377135968',
    status: 'authorized'
  },
  {
    external_id: '179139768764782',
    name: 'WebCamp KL',
    url: 'https://www.facebook.com/groups/179139768764782',
    status: 'authorized'
  },
  {
    external_id: '367080793332853',
    name: 'DevOps Malaysia',
    url: 'https://www.facebook.com/groups/367080793332853',
    status: 'authorized'
  },
  {
    external_id: '375890172559564',
    name: 'Rails Girls Malaysia',
    url: 'https://www.facebook.com/groups/375890172559564',
    status: 'authorized'
  },
  {
    external_id: '340337879386117',
    name: 'AWS User Group - Malaysia',
    url: 'https://www.facebook.com/groups/340337879386117',
    status: 'authorized'
  }
]

groups.each do |group| Group.create(group) end
